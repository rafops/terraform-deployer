# Terraform Deployer

Build deployer:

```
./build.sh
```

Verify AWS credentials are configured correctly by running:

```
aws sts get-caller-identity
```

Run setup:

```
./setup.sh
```

Copy `modules/example` to `modules/custom` and configure `modules/custom/setup.tf.json` replacing UUID with values from previous step output and bucket key prefix with `custom`.

Run terraform commands agains a module:

```
./terraform.sh -chdir=modules/custom init
./terraform.sh -chdir=modules/custom plan
./terraform.sh -chdir=modules/custom apply --auto-approve
./terraform.sh -chdir=modules/custom destroy --auto-approve
```

Alternatively, run a interactive console:

```
./console.sh
```

```
cd custom
terraform init
terraform apply --auto-approve
```

## aws-vault

Using aws-vault to manage AWS CLI credentials is recommended. To install:

```
brew install aws-vault
```

To create a new profile named `development` and store its credentials in the keychain:

```
aws-vault add --backend=keychain development
```

To open a console with the `development` profile:

```
aws-vault exec development ./console.sh
```

To authenticate to a MFA protected `admin` role, configure `~/.aws/config`:

```
[default]
region=us-east-1

[profile development]

[profile production]
source_profile=development
role_arn=arn:aws:iam::111111111111:role/admin
mfa_serial=arn:aws:iam::111111111111:mfa/username
```

To open a console with the `admin` role using the `production` profile (will prompt for MFA):

```
aws-vault exec production ./console.sh
```
