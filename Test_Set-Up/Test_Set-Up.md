

# Test Set-Up for Quick Experimenting :

Below Infra is provisioned as part of basic Test Set-Up.
   1. EC2 Instances - 2 Nos.
   2. Security Groups to allow SSH Login & HTTP Access.

### EC2 Instances :

   2 Nos. of ```t3.medium``` instances are provided.

   A ```t3.medium``` is a low-cost, burstable general-purpose virtual server instance offered by Amazon Web Services (AWS) in the Amazon EC2 (Elastic Compute Cloud) service.
   
   Key Specifications :

   * vCPUs: ```2```
   * Memory (RAM): ```4 GiB```
   * Instance Family: ```General Purpose (t3)```
   * Network Performance: Up to ```5 Gbps```
   * Storage: ```EBS-only``` (Elastic Block Store; no local instance store)
   * Processor: Intel Skylake (E5-2686 v5) running at 3.1 GHz (or          equivalent Intel Xeon Scalable)
   
   

### Security Groups :

| Protocol | Direction | Port Range | Purpose |
| -------- | -------- | -------- | -------- |
| TCP | Inbound | 80 | HTTP Access |
| SSH | Inbound | 22 | Login Access |

