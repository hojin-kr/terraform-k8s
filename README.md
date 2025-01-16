# Terraform & Kubernetes
테라폼으로 쿠버네티스와 쿠버네티스 운영 환경을 구성하기 위한 `best practice architecture`를 만든다.

## Modules
### control-plane
GCP Compute Engine 단일 인스턴스를 쿠버네티스 컨트롤 플레인 설정
- Ubuntu: 22.04 LTS
- Containerd: 1.7.25-1
- Container Network Interface: calico

### workers
GCP Compute Engine 복수 인스턴스를 쿠버네티스 워커 노드로 설정
