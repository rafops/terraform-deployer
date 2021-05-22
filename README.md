# Terraform Deployer

A bootstrap project for Terraform code. It contains the software necessary to run Terraform via a Docker container.

## Build and setup

To build a deployer container:

```
./build.sh
```

This document assumes your shell has AWS CLI credentials configured. To verify if credentials are configured correctly:

```
aws sts get-caller-identity
```

Terraform requires a one-time setup of a DynamoDB and S3 Bucket to store state and perform locking. It also updates setup module with remote state configuration that should be added to version control. To create these resources:

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

## aws-vault

The use of [aws-vault](#aws-vault) is recommended to manage AWS CLI credentials. To install aws-vault:

```
brew install aws-vault
```

Create a new profile named development to store AWS credentials using Keychain:

```
aws-vault add --backend=keychain development
```

To open a console using the development profile credentials:

```
aws-vault exec development ./console.sh
```

You can use cross-account roles and MFA with the following `~/.aws/config` configuration:

```
[default]
region=us-east-1

[profile development]

[profile production]
source_profile=development
role_arn=arn:aws:iam::222222222222:role/production
mfa_serial=arn:aws:iam::111111111111:mfa/username
```

To open a console using the production profile credentials that assumes a cross-account role and prompt for MFA:

```
aws-vault exec production ./console.sh
```

To run terraform commands with aws-vault:

```
aws-vault exec <profile name> -- ./terraform.sh -chdir=modules/<module name> <terraform command>
```
