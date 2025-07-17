project_id   = "testing-practice-462409"
region       = "us-central1"
network_name = "terraform-testing-vpc"
vpc_description="This is the vpc for dev enviroment"
subnet_type="false"
routing_md = "REGIONAL"
enable_ipv6_ula=false
mtu=1460

subnets = [
  {
    name          = "subnet-1"
    ip_cidr_range = "10.10.0.0/16"
    region        = "us-central1"
  },
  {
    name          = "subnet-2"
    ip_cidr_range = "10.20.0.0/16"
    region        = "us-east1"
  }
]


firewall_rules = [
  {
    name          = "allow-ssh"
    #network       = "terraform-testing-vpc"
    direction     = "INGRESS"
    source_ranges = ["0.0.0.0/0"]
    allow = [
      {
        protocol = "tcp"
        ports    = ["22"]
      }
    ]
  },
  {
    name          = "allow-icmp"
    network       = "terraform-testing-vpc"
    direction     = "INGRESS"
    source_ranges = ["0.0.0.0/0"]
    allow = [
      {
        protocol = "icmp"
        ports    = []
      }
    ]
  }
]

nats = [
  {
    name                           = "nat-central"
    router_name                    = "router-central"
    region                         = "us-central1"
    nat_ip_allocate_option         = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  },
  {
    name                           = "nat-east"
    router_name                    = "router-east"
    region                         = "us-east1"
    nat_ip_allocate_option         = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
    subnetworks = [
      {
        name                    = "subnet-2"
        source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
      }
    ]
  }
]



/* dns_zones = [
  {
    name         = "public-zone"
    dns_name     = "example.com."
    description  = "Public zone for example.com"
    visibility   = "public"
  },
  {
    name         = "private-zone"
    dns_name     = "internal.example.com."
    description  = "Private zone for internal.example.com"
    visibility   = "private"
    private_networks = [
      module.vpc.vpc_self_link
    ]
  }
]

*/

buckets = [
  {
    name                        = "tf-dev-logs-bucket"
    location                    = "US"
    storage_class               = "STANDARD"
    force_destroy               = true
    versioning                  = true
    uniform_bucket_level_access = true
    labels = {
      environment = "dev"
      team        = "infra"
    }
    lifecycle_rules = [
      {
        action = {
          type = "Delete"
        }
        condition = {
          age = 30
        }
      }
    ]
  }
]


templates = [
  {
    name                 = "template-1"
    description          = "First instance template"
    tags                 = ["web", "dev"]
    labels               = { environment = "dev" }
    instance_description = "Web Server Template"
    machine_type         = "e2-medium"
    project_id           = "your-project-id"
    region               = "us-central1"

    disks = [
    {
    source_image      = "projects/debian-cloud/global/images/family/debian-11"
    auto_delete       = true
    boot              = true
    resource_policies = []
     }
    ]


    scheduling = {
      automatic_restart   = true
      on_host_maintenance = "MIGRATE"
    }

    network_interfaces = [
      {
        network    = "default"
        subnetwork = "default"
      }
    ]

    service_account = {
      email  = "865174948199-compute@developer.gserviceaccount.com"
      scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    }
  }
]

autopilot_cluster = [
  {
    name                     = "autopilot-cluster-1"
    location                 = "us-central1"
    enterprise_config        = null
    deletion_protection      = false
    cluster_ipv4_cidr_block  = "/17"
    services_ipv4_cidr_block = "/22"
    subnetwork="subnet-1"
  }
]


