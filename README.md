# Terraform Deployer

A bootstrap for Terraform projects with the following characteristics:

- It has essential software to run Terraform
- It uses AWS provider and modules by default but can be adapted to work with any provider
- Terraform commands are executed inside a Docker container shell (console) using host credentials (.aws, .gnupg)
- It follows Terraform and AWS best practices
- It is minimally opinionated

## Deployer container

To build a deployer container:

```
./build.sh
```

## Deployer console

A console is a deployer container shell that using host credentials (.aws, .gnupg).

To run a new console:

```
./console.sh
```

The remaining of commands here documented must be executed inside a console.

## Terraform backend

Terraform requires a one-time setup of `terraform-backend` module to enable remote state and locking.

It also generates a `terraform.tf` configuration in the root module to be included in your source control.

A one-time setup of the backend will happen during a `terraform init` when the `terraform.tf` file does not exist.
