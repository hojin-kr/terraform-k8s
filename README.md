# terraform in gcp
terraform을 사용해서 컨트롤플레인용 노드 1대, 워커 노드 1대를 startup-script를 사용해서 초기화하고 노드간 연결 테스트

# Practice
## Local 환경에서 GCP 로 terraform 을 사용하기 위한 인증
google provider 사용을 위한 인증
```
gcloud auth application-default login

Credentials saved to file: [/Users/****/.config/gcloud/application_default_credentials.json]
```

## control plane 노드 세팅
1. startup-script에 의해서 도커, kubeadm, kubectl등 필요한 패키지 설치
2. kubeadm init 후 node가 세티되어 get nodes로 확인
```
>> terraform apply
gcloud compute ssh --zone=us-central1-a control-plane

>> kubectl get nodes
NAME            STATUS   ROLES           AGE     VERSION
control-plane   Ready    control-plane   2m48s   v1.31.4

>> kubectl get all -n kube-system
NAME                                        READY   STATUS              RESTARTS         AGE
pod/coredns-7c65d6cfc9-2mj64                0/1     ContainerCreating   0                14m
pod/coredns-7c65d6cfc9-jx78w                0/1     ContainerCreating   0                14m
pod/etcd-control-plane                      1/1     Running             6 (14m ago)      13m
pod/kube-apiserver-control-plane            1/1     Running             5 (65s ago)      14m
pod/kube-controller-manager-control-plane   1/1     Running             11 (4m38s ago)   13m
pod/kube-proxy-2pd8l                        0/1     CrashLoopBackOff    6 (110s ago)     14m
pod/kube-scheduler-control-plane            0/1     CrashLoopBackOff    8 (83s ago)      13m

NAME               TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
service/kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   15m

NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/kube-proxy   1         1         0       1            0           kubernetes.io/os=linux   15m

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/coredns   0/2     2            0           15m

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/coredns-7c65d6cfc9   2         2         0       14m

sudo kubeadm token create --print-join-command
kubeadm join 10.128.0.19:6443 --token wdxdjw.gxbkrq46wp62lcj3 --discovery-token-ca-cert-hash sha256:613e8a5bdf477097ee4a1f8e23eb64098c15299784bacc1f3b11d913ca2c8446
```

## worker 노드 세팅
```
terraform apply
gcloud compute ssh --zone=us-central1-a worker

sudo kubeadm join 10.128.0.19:6443 --token wdxdjw.gxbkrq46wp62lcj3 --discovery-token-ca-cert-hash sha256:613e8a5bdf477097ee4a1f8e23eb64098c15299784bacc1f3b11d913ca2c8446 
[preflight] Running pre-flight checks
[preflight] Reading configuration from the cluster...
[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Starting the kubelet
[kubelet-check] Waiting for a healthy kubelet at http://127.0.0.1:10248/healthz. This can take up to 4m0s
[kubelet-check] The kubelet is healthy after 1.001326611s
[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap

```




# Cheatsheet
connect compute engine by gcloud
```
gcloud compute ssh --zone=us-central1-a my-vm
```

check containerd contaners list
```
sudo ctr -n k8s.io containers list
```

generate new join token in control plane
```
sudo kubeadm token create --print-join-command
```