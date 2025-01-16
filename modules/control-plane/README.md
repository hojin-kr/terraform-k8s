# Control-Plane
Kubernetes Contol-Plane을 구성한다.

## startup-script의 설정
- 패키지 시스템 업데이트
- Container Runtime 설치
- 스왑 비활성화
- 쿠버네티스 컨트롤 플레인 설정을 위한 kubeadm 설치
- kubeadm을 사용해 kubernetes 초기화
- Container Network Interface 설치


## Control Plane이 정상적으로 설치된 경우 Kubernetes의 상태 
### get all
```
hojin@tester:~$ kubectl get all -n kube-system
NAME                                           READY   STATUS    RESTARTS   AGE
pod/calico-kube-controllers-7498b9bb4c-r2b9c   1/1     Running   0          45s
pod/calico-node-bfwdt                          1/1     Running   0          45s
pod/coredns-668d6bf9bc-k8jhm                   1/1     Running   0          18m
pod/coredns-668d6bf9bc-xftmb                   1/1     Running   0          18m
pod/etcd-tester                                1/1     Running   0          18m
pod/kube-apiserver-tester                      1/1     Running   0          18m
pod/kube-controller-manager-tester             1/1     Running   0          18m
pod/kube-proxy-q4nfr                           1/1     Running   0          18m
pod/kube-scheduler-tester                      1/1     Running   0          18m

NAME               TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
service/kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   18m

NAME                         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/calico-node   1         1         1       1            1           kubernetes.io/os=linux   45s
daemonset.apps/kube-proxy    1         1         1       1            1           kubernetes.io/os=linux   18m

NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/calico-kube-controllers   1/1     1            1           45s
deployment.apps/coredns                   2/2     2            2           18m

NAME                                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/calico-kube-controllers-7498b9bb4c   1         1         1       45s
replicaset.apps/coredns-668d6bf9bc                   2         2         2       18m
```

### get nodes
```
hojin@tester:~$ kubectl get nodes
NAME     STATUS   ROLES           AGE   VERSION
tester   Ready    control-plane   19m   v1.32.1
```

### Control plane 노드 접근 하여 kubectl 명령 사용을 위한 설정
kubeadm 초기화 후 설정
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## 워커 노드를 추가하는 방법
컨트롤 플레인 노드가 세팅 완료 된 후 워커 노드에 접근하여 kubeadm join 명령을 수행한다. 
### kubeadm ini후 output 사용 
join 명령어를 워커 노드에 접속하여 실행
```
sudo kubeadm join --token <token> <control-plane-host>:<control-plane-port> --discovery-token-ca-cert-hash sha256:<hash>

```
### 컨트롤 플레인에서 join을 위한 정보를 조회 하는 방법
발급된 토큰 목록 조회
```
# Run this on a control plane node
sudo kubeadm token list
```

새로운 토큰 발급
```
# Run this on a control plane node
sudo kubeadm token create
```


