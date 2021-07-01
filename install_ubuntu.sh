#!/usr/bin/env bash

echo "Starting Instalarion of K8s All-in-One"

cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

echo "Install Docker..."
curl -fsSL https://get.docker.com | bash

sudo systemctl enable --now docker
sudo systemctl status docker | grep "Active:"
sudo usermod -aG docker ${USER}

echo "Install K8s..."
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

sudo apt install -y kubelet kubeadm kubectl git --disableexcludes=kubernetes

sudo systemctl enable kubelet

echo "Pull Images K8s..."
kubeadm config images pull

kubeadm init

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

export KUBECONFIG=/etc/kubernetes/admin.conf

echo "Apply Network Polices K8s..."
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

kubectl taint nodes --all node-role.kubernetes.io/master-

echo "Get Nodes K8s..."
kubectl get nodes

echo "Get All namespaces Default"
kubectl get all