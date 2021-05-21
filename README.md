# Terraform Deployer

Build deployer:

```
./build.sh
```

Run setup:

```
./setup.sh
```

Copy `modules/example` to `modules/custom` and configure `modules/custom/setup.tf.json` replacing UUID with values from previous step output and bucket key prefix with `custom`.

Deploy:

```
./terraform.sh -chdir=modules/custom init
./terraform.sh -chdir=modules/custom plan
./terraform.sh -chdir=modules/custom apply --auto-approve
./terraform.sh -chdir=modules/custom destroy --auto-approve
```
