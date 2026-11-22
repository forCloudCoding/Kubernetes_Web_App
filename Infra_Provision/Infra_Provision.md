

# Infrastructure Provisioning using Terraform :

Below listed Infra is needed :
   1. EC2 Instances - 3 Nos.
   2. Security Groups to allow communication between Kubernetes Cluster Components.

### EC2 Instances :

   * 1 No. for Control Plane - atleast 2 vCPUs.
   * 2 Nos. for Data Plane

### Security Groups :

Reference : https://kubernetes.io/docs/reference/networking/ports-and-protocols/

In an environment with strict network boundaries, such as on-premises datacenter with physical network firewalls or Virtual Networks in Public Cloud, below Ports and Protocols should be kept open:

For Control Plane : 

| Protocol | Direction | Port Range | Purpose | Used By |
| -------- | -------- | -------- | -------- | -------- |
| TCP | Inbound | 6443 | Kubernetes API server | All |
| TCP | Inbound | 2379-2380 | etcd server client API | kube-apiserver, etcd |
| TCP | Inbound | 10250 | Kubelet API | Self, Control plane |
| TCP | Inbound | 10259 | kube-scheduler | Self |
| TCP | Inbound | 10257 | kube-controller-manager | Self |

For Data Plane :

| Protocol | Direction | Port Range | Purpose | Used By |
| -------- | -------- | -------- | -------- | -------- |
| TCP | Inbound | 10250 | Kubelet API | Self, Control plane |
| TCP | Inbound | 10256 | kube-proxy | Self, Load balancers |
| TCP | Inbound | 30000-32767 | NodePort Services† | All |
| UDP | Inbound | 30000-32767 | NodePort Services† | All |

### Set-up Kubernetes Cluster using bash script :

   1. Execute the bash script on all 3 Nodes to configure prerequisites of Kubernetes Cluster. [ Script : bash_script_for_node_config.sh ]
   2. Initialize the Control Plane (on Control Node Only) ```sudo kubeadm init --pod-network-cidr=192.168.0.0/16```
   3. Note the output of Step 2. needed for configuring the Control Node and Joining the Worker Nodes.
   4. Install the CNI on Control Node ```kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.31.1/manifests/calico.yaml```
   5. Joining the Worker Nodes should be executed as a Root User. ```sudo kubeadm join <control-plane-internal-ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>```
   6. Check Cluster Node Status ```kubectl get nodes```
   7. Check Cluster Components Health ```kubectl get pods -A```
   8. Run a Test Deployment to Confirm Functionality ```kubectl create deployment nginx --image=nginx```

