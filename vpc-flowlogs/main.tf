# Flow logs main

resource "aws_flow_log" "main" {
  log_destination      = "${aws_s3_bucket.main.arn}"
  log_destination_type = "s3"
  iam_role_arn         = "${aws_iam_role.main.arn}"
  vpc_id               = "${var.vpc_id}"
  traffic_type         = "ALL"
}

# IAM role to store network logs
resource "aws_iam_role" "main" {
  name = "${terraform.workspace}-vpc-flow-logs"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# IAM policy authorizing the IAM role
resource "aws_iam_role_policy" "main" {
  name = "${terraform.workspace}-vpc-flow-logs"
  role = "${aws_iam_role.main.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogDelivery",
        "logs:DeleteLogDelivery"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
