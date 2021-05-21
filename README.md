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
