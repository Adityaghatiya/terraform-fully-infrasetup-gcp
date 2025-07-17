provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source       = "./modules/vpc"
  project_id   = var.project_id
  network_name = var.network_name
  vpc_description=var.vpc_description
  subnet_type=var.subnet_type
  routing_md=var.routing_md
  enable_ipv6_ula=var.enable_ipv6_ula
  mtu=var.mtu
}

module "subnet" {
  source        = "./modules/subnet"
  project_id    = var.project_id
  vpc_self_link = module.vpc.vpc_self_link
  subnets       = var.subnets
}

module "firewall" {
  source         = "./modules/firewall"
  project_id     = var.project_id
  firewall_rules = var.firewall_rules
  
  vpc_self_link = module.vpc.vpc_self_link
}

module "cloudrouter" {
  source     = "./modules/cloudrouter"
  project_id = var.project_id
  routers = [
    {
      name          = "router-central"
      vpc_self_link = module.vpc.vpc_self_link
      region        = "us-central1"
    },
    {
      name          = "router-east"
      vpc_self_link = module.vpc.vpc_self_link
      region        = "us-east1"
    }
  ]
}

module "cloudnat" {
  source     = "./modules/cloudnat"
  project_id = var.project_id
  nats       = var.nats
}

module "clouddns" {
  source     = "./modules/clouddns"
  project_id = var.project_id
  dns_zones = [
    {
      name         = "private-zone"
      dns_name     = "internal.example.com."
      description  = "Private internal DNS zone"
      visibility   = "private"
      private_networks = [module.vpc.vpc_self_link]
    }
  ]
}


module "storage" {
  source     = "./modules/storage"
  project_id = var.project_id
  buckets    = var.buckets
}

module "templates" {
  source     = "./modules/vmtemplate"
  project_id=var.project_id
  templates  = var.templates
}

module "gke_autopilot"{
  source="./modules/gke_autopilot"
  project_id=var.project_id
  autopilot_cluster=var.autopilot_cluster
  network= module.vpc.vpc_self_link
}

module "autohealing"{
source="./modules/autohealing"
autohealing=var.autohealing
}

module "instance_group"{
source="./modules/managedgroup"
instance_group=var.instance_group
}