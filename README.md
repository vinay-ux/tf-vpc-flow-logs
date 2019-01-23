# tf-vpc-flow-logs
===========

Terraform module for deploying and managing vpc flow logs to s3

This module

- Pushes vpc flow logs to s3

----------------------
#### Required
- `vpc_id`  - "VPC ID"

```hcl
Usage
-----
module "vpc-flow-logs" {
  source = "github.com/vinay-ux/tf-vpc-flow-logs//vpc-flowlogs"
  vpc_id = "${module.vpc.vpc_id}"
}
```
