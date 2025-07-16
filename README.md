Modular and dynamic Terraform setup to provision complete GCP infrastructure including VPCs, Subnets, NAT, Routers, Firewalls, DNS, Storage, and more — designed for scalable, multi-region cloud environments.

# 🌐 GCP Infrastructure Deployment using Terraform

This project provisions a modular, dynamic, and scalable Google Cloud Platform (GCP) infrastructure using Terraform. Each component (VPC, Subnet, Firewall, NAT, DNS, etc.) is broken into its own reusable module for better maintainability and flexibility.

---

<pre>
<details open>
<summary>📁 <strong>Project Structure</strong></summary>

terraform-template/
├── main.tf                     # Root module orchestrating all resources
├── terraform.tfvars            # All configurable variables
├── variables.tf                # Input variables for root module
├── modules/
│   ├── vpc/                    # VPC network module
│   ├── subnet/                 # Subnet module
│   ├── firewall/               # Firewall rules module
│   ├── cloudrouter/            # Cloud Router module
│   ├── cloudnat/               # Cloud NAT module
│   ├── clouddns/               # Cloud DNS module
│   ├── storage/                # Cloud Storage buckets
│   ├── vm-mig/                 # Compute Instance Group module
│   ├── loadbalancer/           # Load Balancer module
│   ├── cloudsql/               # Cloud SQL module
│   └── logging-sink/           # Logging sink module

</details>
</pre>



---

## 🚀 What’s Provisioned

- VPC with custom configurations (MTU, routing mode, IPv6, etc.)
- Regional Subnets
- Dynamic Firewall Rules
- Cloud Routers and Cloud NATs
- Private and Public Cloud DNS Zones
- Cloud Storage Buckets (standard, nearline, etc.)
- Additional modules for VM Instance Group, Load Balancer, CloudSQL, Logging (in progress)

---

## 📦 Requirements
-Ide:- VS code with terraform extension
- Terraform CLI >= 1.4
- Google Cloud CLI (`gcloud`) authenticated
- A GCP Project with necessary APIs enabled:
  - Compute Engine
  - Cloud NAT
  - Cloud DNS
  - Cloud Storage
  - Cloud SQL (if used)
  - IAM & Logging APIs
  
---

💻 Terraform Commands Guide
<pre> <details open> <summary><strong>⚙️ Common Terraform CLI Commands</strong></summary> 📦 <strong>Initialize Terraform directory</strong> terraform init 🔍 <strong>Preview changes before applying</strong> terraform plan 🚀 <strong>Apply infrastructure changes</strong> terraform apply 🔥 <strong>Destroy all managed infrastructure</strong> terraform destroy 🧹 <strong>Format Terraform files</strong> terraform fmt ✅ <strong>Validate configuration files</strong> terraform validate 📋 <strong>Show current state (optional)</strong> terraform show </details> </pre>

---

🔧 Usage
This setup is fully modular and dynamic, designed for reuse across multiple projects or environments (dev/stage/prod).

You can easily:
- Add or modify resources by changing variables
- Extend modules as per future infrastructure needs

⚠️ Note: Not all input values are defined in the current setup. Only the modules required for the current deployment are enabled. 


