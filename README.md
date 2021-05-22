# Terraform Deployer

Terraform Deployer is a bootstrap project for Terraform code. It contains the software necessary to run Terraform using a Docker container.

To build deployer container:

```
./build.sh
```

The use of [aws-vault](doc/aws-vault.md) is recommended to manage AWS CLI credentials. This document assumes your shell has AWS CLI credentials configured. To verify if credentials are configured correctly:

```
aws sts get-caller-identity
```

Terraform requires a one-time setup of a DynamoDB and S3 Bucket to store state and perform locking. It also updates modules/setup.tf and creates modules/setup/terraform.tf that should be added to version control. To create these resources:

```
./setup.sh
```

## Modules

Terraform code can be structured using many individual modules. To create a new module:

```
./create modulename
```

To perform terraform commands in the new module:

```
./terraform.sh -chdir=modules/modulename init
./terraform.sh -chdir=modules/modulename plan
./terraform.sh -chdir=modules/modulename apply -auto-approve
./terraform.sh -chdir=modules/modulename destroy -auto-approve
```

Alternatively, run an interactive console:

```
./console.sh
```

```
cd modulename
terraform init
terraform apply -auto-approve
```
