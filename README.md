# Terraform Deployer

A bootstrap for Terraform projects. It contains a Docker container with essential software to run Terraform and a structure that follows Terraform best practices.

## Deployer container

To build a deployer container:

```
./build.sh
```

## AWS CLI credentials

This document assumes your shell is configured with proper credentials to run AWS CLI commands and Terraform. To verify if credentials are configured:

```
aws sts get-caller-identity
```

## Setup remote backend

Terraform requires a one-time setup of `terraform-backend` module to enable remote state and locking. It also generates a `terraform.tf` configuration to be added to the version control. To run the one-time setup:

```
./setup.sh
```

## Terraform commands and console

Example of Terraform commands using the deployer container:

```
./terraform.sh plan
./terraform.sh apply -auto-approve
./terraform.sh destroy -auto-approve
```

Alternatively, run the deployer container as an interactive shell:

```
./console.sh
```

From the console, run Terraform commands as usual:

```
terraform plan
terraform apply -auto-approve
```

## Manage AWS CLI credentials with aws-vault

The [aws-vault](https://github.com/99designs/aws-vault) tool is recommended to manage AWS CLI credentials. To install `aws-vault`:

```
brew install aws-vault
```

Create a new profile named `development` to store AWS CLI credentials on Keychain:

```
aws-vault add --backend=keychain development
```

To open a console using `development` credentials:

```
aws-vault exec development ./console.sh
```

Users can assume cross-account roles and require MFA token by configuring `~/.aws/config`:

```
[default]
region=us-east-1

[profile development]

[profile production]
source_profile=development
role_arn=arn:aws:iam::222222222222:role/production
mfa_serial=arn:aws:iam::111111111111:mfa/username
```

To open a console using `production` credentials that assumes a cross-account role and requires MFA:

```
aws-vault exec production ./console.sh
```
