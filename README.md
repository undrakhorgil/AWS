# 1. IAM user creation
### ✅ Initialize the Terraform project folder.
(base) mac@mac AWS % terraform init             
```bash
Initializing the backend...
Initializing modules...
- aws_iam_user in ../../../../infra-modules/iam-user
Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v5.100.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
### ✅ Preview changes before applying.

(base) mac@mac AWS % terraform plan             
```bash
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.aws_iam_user.aws_iam_user.this will be created
  + resource "aws_iam_user" "this" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "terraform-dev-user"
      + path          = "/"
      + tags          = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
        }
      + tags_all      = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
        }
      + unique_id     = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```
### ✅ Apply the planned changes.

(base) mac@mac AWS % terraform apply
```bash
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.aws_iam_user.aws_iam_user.this will be created
  + resource "aws_iam_user" "this" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "terraform-dev-user"
      + path          = "/"
      + tags          = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
        }
      + tags_all      = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
        }
      + unique_id     = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.aws_iam_user.aws_iam_user.this: Creating...
module.aws_iam_user.aws_iam_user.this: Creation complete after 0s [id=terraform-dev-user]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

![AIM user](images/iam_user.png)

### ✅ Let’s change a value manually in AWS and use Terraform to detect the drift.

![AIM user](images/iam_user_change.png)

(base) mac@mac iam-users % terraform plan -refresh-only -detailed-exitcode
```bash
module.aws_iam_user.aws_iam_user.this: Refreshing state... [id=terraform-dev-user]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # module.aws_iam_user.aws_iam_user.this has changed
  ~ resource "aws_iam_user" "this" {
        id                   = "terraform-dev-user"
        name                 = "terraform-dev-user"
      ~ tags                 = {
            "Environment" = "dev"
            "ManagedBy"   = "Terraform"
          ~ "Owner"       = "orgil" -> "unkhown"
            "Project"     = "terraform-learning"
        }
      ~ tags_all             = {
          ~ "Owner"       = "orgil" -> "unkhown"
            # (3 unchanged elements hidden)
        }
        # (5 unchanged attributes hidden)
    }


This is a refresh-only plan, so Terraform will not take any actions to undo these. If you were expecting these changes then you can apply this plan to record the updated values in
the Terraform state without changing any remote objects.

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

### ✅ Accept drift into state

(base) mac@mac iam-users % terraform apply -refresh-only    
```bash          
module.aws_iam_user.aws_iam_user.this: Refreshing state... [id=terraform-dev-user]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # module.aws_iam_user.aws_iam_user.this has changed
  ~ resource "aws_iam_user" "this" {
        id                   = "terraform-dev-user"
        name                 = "terraform-dev-user"
      ~ tags                 = {
            "Environment" = "dev"
            "ManagedBy"   = "Terraform"
          ~ "Owner"       = "orgil" -> "unkhown"
            "Project"     = "terraform-learning"
        }
      ~ tags_all             = {
          ~ "Owner"       = "orgil" -> "unkhown"
            # (3 unchanged elements hidden)
        }
        # (5 unchanged attributes hidden)
    }


This is a refresh-only plan, so Terraform will not take any actions to undo these. If you were expecting these changes then you can apply this plan to record the updated values in
the Terraform state without changing any remote objects.

Would you like to update the Terraform state to reflect these detected changes?
  Terraform will write these changes to the state without modifying any real infrastructure.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

### ✅ Remove all resources managed by this Terraform folder/state

(base) mac@mac iam-users % terraform destroy
```bash
module.aws_iam_user.aws_iam_user.this: Refreshing state... [id=terraform-dev-user]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # module.aws_iam_user.aws_iam_user.this will be destroyed
  - resource "aws_iam_user" "this" {
      - arn                  = "arn:aws:iam::**********:user/terraform-dev-user" -> null
      - force_destroy        = false -> null
      - id                   = "terraform-dev-user" -> null
      - name                 = "terraform-dev-user" -> null
      - path                 = "/" -> null
      - tags                 = {
          - "Environment" = "dev"
          - "ManagedBy"   = "Terraform"
          - "Owner"       = "orgil"
          - "Project"     = "terraform-learning"
        } -> null
      - tags_all             = {
          - "Environment" = "dev"
          - "ManagedBy"   = "Terraform"
          - "Owner"       = "orgil"
          - "Project"     = "terraform-learning"
        } -> null
      - unique_id            = "**********" -> null
        # (1 unchanged attribute hidden)
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.aws_iam_user.aws_iam_user.this: Destroying... [id=terraform-dev-user]
module.aws_iam_user.aws_iam_user.this: Destruction complete after 0s

Destroy complete! Resources: 1 destroyed.
```
# 2. VPC (public,private subnets)

(base) mac@mac vpc % terraform apply  
```
bash
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.vpc.aws_internet_gateway.this will be created
  + resource "aws_internet_gateway" "this" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Environment" = "dev"
          + "Name"        = "dev-vpc-igw"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
        }
      + tags_all = {
          + "Environment" = "dev"
          + "Name"        = "dev-vpc-igw"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
        }
      + vpc_id   = (known after apply)
    }

  # module.vpc.aws_route_table.private will be created
  + resource "aws_route_table" "private" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = (known after apply)
      + tags             = {
          + "Environment" = "dev"
          + "Name"        = "dev-vpc-private-rt"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
        }
      + tags_all         = {
          + "Environment" = "dev"
          + "Name"        = "dev-vpc-private-rt"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
        }
      + vpc_id           = (known after apply)
    }

  # module.vpc.aws_route_table.public will be created
  + resource "aws_route_table" "public" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                 = "0.0.0.0/0"
              + gateway_id                 = (known after apply)
                # (11 unchanged attributes hidden)
            },
        ]
      + tags             = {
          + "Environment" = "dev"
          + "Name"        = "dev-vpc-public-rt"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
        }
      + tags_all         = {
          + "Environment" = "dev"
          + "Name"        = "dev-vpc-public-rt"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
        }
      + vpc_id           = (known after apply)
    }

  # module.vpc.aws_route_table_association.private_a will be created
  + resource "aws_route_table_association" "private_a" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.vpc.aws_route_table_association.public_a will be created
  + resource "aws_route_table_association" "public_a" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.vpc.aws_subnet.private_a will be created
  + resource "aws_subnet" "private_a" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.10.2.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Environment" = "dev"
          + "Name"        = "dev-vpc-private-a"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
          + "Tier"        = "private"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "Name"        = "dev-vpc-private-a"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
          + "Tier"        = "private"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_subnet.public_a will be created
  + resource "aws_subnet" "public_a" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.10.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Environment" = "dev"
          + "Name"        = "dev-vpc-public-a"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
          + "Tier"        = "public"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "Name"        = "dev-vpc-public-a"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
          + "Tier"        = "public"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_vpc.this will be created
  + resource "aws_vpc" "this" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.10.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "dev-vpc"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
        }
      + tags_all                             = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "dev-vpc"
          + "Owner"       = "orgil"
          + "Project"     = "terraform-learning"
        }
    }

Plan: 8 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.vpc.aws_vpc.this: Creating...
module.vpc.aws_vpc.this: Still creating... [00m10s elapsed]
module.vpc.aws_vpc.this: Creation complete after 12s [id=vpc-************]
module.vpc.aws_internet_gateway.this: Creating...
module.vpc.aws_subnet.private_a: Creating...
module.vpc.aws_route_table.private: Creating...
module.vpc.aws_subnet.public_a: Creating...
module.vpc.aws_internet_gateway.this: Creation complete after 1s [id=igw--************]]
module.vpc.aws_route_table.public: Creating...
module.vpc.aws_route_table.private: Creation complete after 2s [id=rtb--************]]
module.vpc.aws_subnet.private_a: Creation complete after 2s [id=subnet--************]]
module.vpc.aws_route_table_association.private_a: Creating...
module.vpc.aws_route_table_association.private_a: Creation complete after 0s [id=rtbassoc--************]]
module.vpc.aws_route_table.public: Creation complete after 2s [id=rtb--************]]
module.vpc.aws_subnet.public_a: Still creating... [00m10s elapsed]
module.vpc.aws_subnet.public_a: Creation complete after 12s [id=subnet--************]]
module.vpc.aws_route_table_association.public_a: Creating...
module.vpc.aws_route_table_association.public_a: Creation complete after 1s [id=rtbassoc--************]]

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.
```