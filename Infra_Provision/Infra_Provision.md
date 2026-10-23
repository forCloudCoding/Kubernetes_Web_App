

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

