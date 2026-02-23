# 1. IAM user creation

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

![AIM user](images/IAM_user.png)


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