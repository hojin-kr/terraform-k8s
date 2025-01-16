#!/bin/bash
# 스크립트가 실행되는 시점에는 배포를 위한 확인과 승인은 진행 된것으로 판단

set -e

terraform init
terraform apply -auto-approve

CONTROL_PLANNE_ZONE=$(terraform output control-plane-zone | tr -d '"')
CONTROL_PLANNE_NAME=$(terraform output control-plane-name | tr -d '"')

# 웜업 대기
echo "웜업 대기중..."
# sleep 120

# ssh 접속이 가능한지 반복해서 확인한다. 
while ! gcloud compute ssh --zone $CONTROL_PLANNE_ZONE $CONTROL_PLANNE_NAME --command "echo 'SSH into control plane node is working!'" ; do
  echo "컨트롤 플레인 노드 접속을 위해 대기중..."
  sleep 5
done

# CNI 설치
# Container Network Interface 가 없으면 Pod이 스케쥴링 되지 않는다.
# CoreDNS가 Pending 상태로 유지되고, Control Plann 노드가 NotReady 상태로 유지된다.
gcloud compute ssh --zone $CONTROL_PLANNE_ZONE $CONTROL_PLANNE_NAME --command "sudo mkdir -p $HOME/.kube && sudo cp -rf /etc/kubernetes/admin.conf $HOME/.kube/config && sudo chown $(id -u):$(id -g) $HOME/.kube/config && kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml"

# control plane 노드에서 /home/token/kubeadm_join_cmd.sh 를 복사해온다.
gcloud compute ssh --zone $CONTROL_PLANNE_ZONE $CONTROL_PLANNE_NAME --command "sudo kubeadm token create --print-join-command > /tmp/kubeadm_join_cmd.sh"
gcloud compute scp --zone $CONTROL_PLANNE_ZONE $CONTROL_PLANNE_NAME:/tmp/kubeadm_join_cmd.sh .

echo "kubeadm_join_cmd.sh 파일을 생성"

WORKER_ZONE=$(terraform output workers-zone | tr -d '"')
WORKER_NAME=$(terraform output workers-name | tr -d '"')

# worker 노드로 업로드 후 실행한다.
gcloud compute scp --zone $WORKER_ZONE kubeadm_join_cmd.sh $WORKER_NAME:/tmp/kubeadm_join_cmd.sh
gcloud compute ssh --zone $WORKER_ZONE $WORKER_NAME --command "chmod +x /tmp/kubeadm_join_cmd.sh && sudo /tmp/kubeadm_join_cmd.sh"

echo "worker 노드에 kubeadm_join_cmd.sh 파일을 전송하고 실행"