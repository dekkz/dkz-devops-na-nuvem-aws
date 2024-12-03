variable "tags" {
  type = map(string)
  default = {
    "owner"   = "dkz"
    "project" = "dkz-devops-na-nuvem"
    "environment" : "production"
  }
}

variable "vpc" {
  type = object({
    name                     = string
    cidr_block               = string
    internet_gateway_name    = string
    nat_gateway_name         = string
    public_route_table_name  = string
    private_route_table_name = string
    eip                      = string
    public_subnets = list(object({
      name                    = string
      map_public_ip_on_launch = bool
      availability_zone       = string
      cidr_block              = string
    }))
    private_subnets = list(object({
      name                    = string
      map_public_ip_on_launch = bool
      availability_zone       = string
      cidr_block              = string
    }))
  })

  default = {
    name                     = "dkz-devops-na-nuvem"
    cidr_block               = "10.0.0.0/24"
    internet_gateway_name    = "dkz-devops-na-nuvem-vpc-internet-gateway"
    nat_gateway_name         = "dkz-devops-na-nuvem-vpc-nat-gateway"
    public_route_table_name  = "dkz-devops-na-nuvem-vpc-public-route-table"
    private_route_table_name = "dkz-devops-na-nuvem-vpc-private-route-table"
    eip                      = "dkz-devops-na-nuvem-vpc-eip"
    public_subnets = [
      {
        name                    = "dkz-devops-na-nuvem-vpc-public-subnet-us-east-1a"
        map_public_ip_on_launch = true
        availability_zone       = "us-east-1a"
        cidr_block              = "10.0.0.0/26"
      },
      {
        name                    = "dkz-devops-na-nuvem-vpc-public-subnet-us-east-1b"
        map_public_ip_on_launch = true
        availability_zone       = "us-east-1b"
        cidr_block              = "10.0.0.64/26"
      }
    ]
    private_subnets = [
      {
        name                    = "dkz-devops-na-nuvem-vpc-private-subnet-us-east-1a"
        map_public_ip_on_launch = false
        availability_zone       = "us-east-1a"
        cidr_block              = "10.0.0.128/26"
      },
      {
        name                    = "dkz-devops-na-nuvem-vpc-private-subnet-us-east-1b"
        map_public_ip_on_launch = false
        availability_zone       = "us-east-1b"
        cidr_block              = "10.0.0.192/26"
      }
    ]
  }

}

variable "eks_cluster" {
  type = object({
    name                              = string
    role_name                         = string
    enabled_cluster_log_types         = list(string)
    access_config_authentication_mode = string
    node_group = object({
      name                        = string
      role_name                   = string
      instance_types              = list(string)
      scaling_config_max_size     = number
      scaling_config_min_size     = number
      scaling_config_desired_size = number
      capacity_type               = string
    })

  })

  default = {
    name      = "dkz-devops-na-nuvem-eks-cluster"
    role_name = "DKZDevOpsNaNuvemEKSClusterRole"
    enabled_cluster_log_types = [
      "api",
      "audit",
      "authenticator",
      "controllerManager",
      "scheduler"
    ]
    access_config_authentication_mode = "API_AND_CONFIG_MAP"
    node_group = {
      name                        = "dkz-devops-na-nuvem-eks-cluster-node-group"
      role_name                   = "DKZDevOpsNaNuvemEKSClusterNodeGroupRole"
      instance_types              = ["t3.medium"]
      scaling_config_max_size     = 2
      scaling_config_min_size     = 2
      scaling_config_desired_size = 2
      capacity_type               = "ON_DEMAND"
    }
  }
}