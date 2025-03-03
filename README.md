# README

## Pre-requisite

- [Docker Desktop with buildx plugin](https://docs.docker.com/desktop/):
- AWS CLI Installed and AWS Profile Created:
  - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
  - [AWS Profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
- [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- ECR Repo and S3 Bucket Created follow below steps:

### Command

#### Create S3 and ECR

```bash
# create s3 bucket
aws s3api create-bucket --bucket <terraform_state_bucket_name> --profile <aws_profile> --region <aws_region> --create-bucket-configuration LocationConstraint=<aws_region>
```

```bash
# enable versioning in the created bucket
aws s3api put-bucket-versioning --bucket <terraform_state_bucket_name> --versioning-configuration Status=Enabled --profile <aws_profile> --region <aws_region>
```

```bash
# create ecr repo
aws ecr create-repository --repository-name <ecr_repo_name> --profile <aws_profile> --region <aws_region>
```

```bash
# set repo permission so that lambda can pull image
aws ecr set-repository-policy --repository-name <ecr_repo_name> --profile <aws_profile> --region <aws_region> --policy-text file://ecr-policy.json
```

```bash
# docker client authentication with ecr
aws ecr get-login-password --profile <aws_profile> --region <aws_region> | docker login --username AWS --password-stdin <ecr_repo_url>
```

```bash
# build tag and push image to ecr
docker buildx build --platform linux/arm64 --provenance=false -t <ecr_repo_url>:<image_tag> --push .
```

#### Delete S3 and ECR

```bash
# delete ecr
aws ecr delete-repository --repository-name <ecr_repo_name> --force --profile <aws_profile> --region <aws_region>
```

### References

- [BuildX](https://docs.docker.com/reference/cli/docker/buildx/)
- [Terraform AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Archive](https://registry.terraform.io/providers/hashicorp/archive/latest/docs)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/)
- [SpaceX](https://github.com/r-spacex/SpaceX-API/blob/master/docs/launches/v5/latest.md)
- [Non Base Image AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-image-clients)
- [ECR Permission](https://docs.aws.amazon.com/lambda/latest/dg/images-create.html)
