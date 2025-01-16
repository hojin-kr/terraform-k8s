# cheatsheet
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