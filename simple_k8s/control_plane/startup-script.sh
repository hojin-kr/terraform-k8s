#!/bin/bash

set -e

echo "[Step 1] 시스템 업데이트"
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

echo "[Step 2] CRI 설치 (Container Runtime)"
# Docker는 더 이상 Kubernetes에서 사용하지 않는다. 

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y containerd.io
sudo systemctl enable containerd
sudo systemctl start containerd

# Contanerd, runC 설정
# sudo vi /etc/sysctl.conf 의 net.ipv4.ip_forward 주석 해제
# >> error execution phase preflight: [preflight] Some fatal errors occurred:
# 	[ERROR FileContent--proc-sys-net-ipv4-ip_forward]: /proc/sys/net/ipv4/ip_forward contents are not set to 1
sudo sed -i '/net.ipv4.ip_forward/s/^#//g' /etc/sysctl.conf
sudo sysctl -p

# disabled_plugins* 주석 처리
sudo sed -i '/disabled_plugins/s/^/#/' /etc/containerd/config.toml

# runc
wget https://github.com/opencontainers/runc/releases/download/v1.1.1/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc

sudo systemctl restart containerd


echo "[Step 3] Kubernetes 패키지 저장소 추가"
# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "[Step 4] Kubernetes 설치"
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "[Step 5] Swap 비활성화"
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

echo "[Step 6] Kubernetes Control Plane 초기화"
sudo kubeadm init

echo "[Step 7] kubectl 설정"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo ufw allow 6443/tcp   # Kubernetes API 서버
sudo ufw allow 10250/tcp  # Kubelet API
sudo ufw allow 30000:32767/tcp  # NodePort 서비스
sudo ufw reload

echo "[Step 8] 네트워크 플러그인 설치"
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# echo "Kubernetes Control Plane 설치가 완료되었습니다."
# echo "Worker 노드를 추가하려면 'kubeadm join' 명령어를 실행하세요."
