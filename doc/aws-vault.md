# aws-vault

To install aws-vault:

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

To open a console with production role and prompt for MFA:

```
aws-vault exec production ./console.sh
```
