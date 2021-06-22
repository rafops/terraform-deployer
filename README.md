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

A console is a deployer container interactive shell. To run a new console:

```
./console.sh
```

The remaining of commands here documented are intended to run from a console shell.

## Terraform backend

Terraform requires a one-time setup of `terraform-backend` module to enable remote state and locking.

The `configure-terraform-backend` command generates a `terraform.tf` configuration in the root module.

Add `terraform.tf` to the source control of your project.
