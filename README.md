# Terraform & Kubernetes
테라폼으로 쿠버네티스와 쿠버네티스 운영 환경을 구성하기 위한 `best practice architecture`를 만든다.
## Terraform
### k8s
쿠버네티스 컨트롤 플레인과 워커노드를 각각 단일 노드에 대해서 클러스터링

## Modules
### control-plane
GCP Compute Engine 단일 인스턴스를 쿠버네티스 컨트롤 플레인 설정
- Ubuntu: 22.04 LTS
- Containerd: 1.7.25-1
- Container Network Interface: calico

### workers
GCP Compute Engine 복수 인스턴스를 쿠버네티스 워커 노드로 설정


## 배포 스크립트 k8s/deploy.sh
사용되는 Terraform으로 인프라 스트럭처를 구성하고 Helm으로 쿠버네티스에 필요한 초기화 세팅을 진행한다.

1. 컨트롤 플레인 노드 세팅
2. 워커 노드 세팅
3. 쿠버네티스 시스템 웜엄 대기
3. 컨테이너 네트워크 인터페이스 설치
    startup-script에서 실행할 경우 실행되지 못하는 경우가 생긴다.
4. 컨트롤 플레인에 워커 노드를 등록하기 위해 token 생성
5. 워커 노드에서 토큰을 통해 join 실행

```
hojin@control-plane01:~$ kubectl get nodes
NAME              STATUS   ROLES           AGE     VERSION
control-plane01   Ready    control-plane   7m28s   v1.32.1
worker01          Ready    <none>          3m27s   v1.32.1
```

## TODO
- 고가용성 컨트롤 플레인 클러스터링
- 복수의 워커 노드 클러스터링
- 멀티 클라우드 노드 사용
- 쿠버네티스 운영을 위한 기본 세팅
    - Helm 차트로 모니터링, 서비스 메시 세팅