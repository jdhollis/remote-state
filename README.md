# `remote-state`

## Introduction

This module provides the necessary infrastructure for storing remote Terraform state. This includes an S3 bucket for storing the state files, a KMS key for encrypting the state at rest, and a DynamoDB table for handling state locking.

You can read more about Terraform state [here](https://www.terraform.io/docs/state/index.html) and backends [here](https://www.terraform.io/docs/backends/). We are using the [S3 backend](https://www.terraform.io/docs/backends/types/s3.html).

## AWS

All Terraform and scripts assume you have the AWS CLI tools installed. On the Mac, you can install them via [Homebrew](https://brew.sh):

```bash
brew install awscli
```

### Credentials

All of the Terraform assumes that you have configured your AWS credentials the following way:

#### `~/.aws/credentials`

```ini
[ops]
aws_access_key_id = …
aws_secret_access_key = …
```

#### `~/.aws/config`

```ini
[profile ops]

[profile ops-tools]
source_profile = ops
role_arn = arn:aws:iam::[TOOLS_ACCOUNT_ID]:role/Ops

[profile ops-dev]
source_profile = ops
role_arn = arn:aws:iam::[DEV_ACCOUNT_ID]:role/Ops

[profile ops-stage]
source_profile = ops
role_arn = arn:aws:iam::[STAGE_ACCOUNT_ID]:role/Ops

[profile ops-prod]
source_profile = ops
role_arn = arn:aws:iam::[PROD_ACCOUNT_ID]:role/Ops
```

You can configure using [`aws configure`](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) or edit the files directly.

## Bootstrapping

To bootstrap `remote-state`, run:

```bash
terraform init
terraform plan -out plan
terraform apply plan
```

Once the infrastructure has been created, uncomment the `terraform > backend` block and update the details for the new environment you've just bootstrapped.

Then:

```bash
terraform init
terraform plan -out plan
terraform apply plan
```

You will be asked during `init` whether you want to move your local state to the remote backend. Do so.
