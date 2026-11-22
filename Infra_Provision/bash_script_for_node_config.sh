
#!/bin/bash
echo "Script to Configure EC2 Instances for Kubernetes Set-Up."

# Before installing anything, update the system packages
sudo apt update
sudo apt upgrade -y

# Disable Swap
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

# Load Required Kernel Modules
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Set System Networking Parameters
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system

# Install the Container Runtime (containerd)
sudo apt install -y containerd

# Generate default config
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml

# Enable and start the service
sudo systemctl restart containerd
sudo systemctl enable containerd

# Install Kubernetes with kubeadm
# Install kubeadm, kubelet, and kubectl

# Add Kubernetes APT repository
sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.37/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.37/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg


# Install the components
sudo apt update
sudo apt install -y kubelet kubeadm kubectl

# Prevent automatic updates
sudo apt-mark hold kubelet kubeadm kubectl

