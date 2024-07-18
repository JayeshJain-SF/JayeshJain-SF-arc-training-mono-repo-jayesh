# Reference Architecture DevOps Infrastructure: [EC2]
## Overview

AWS EC2 for the SourceFuse DevOps training.  

## Usage
1. Initialize the backend:
  ```shell
  terraform init -backend-config config.dev.hcl
  ```
2. Create a `dev` workspace
  ```shell
  terraform workspace new dev
  ```
3. Plan Terraform
  ```shell
  terraform plan -var-file dev.tfvars
  ```
4. Apply Terraform
  ```shell
  terraform apply -var-file dev.tfvars
  ```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
