# IAM Role for RDS
resource "aws_iam_role" "rds_role" {
  name = "${var.db_identifier}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "rds.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for RDS
resource "aws_iam_policy" "rds_policy" {
  name        = "${var.db_identifier}-policy"
  path        = "/"
  description = "IAM policy for RDS instance"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.s3_bucket_name}"
      },
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "rds_attach" {
  role       = aws_iam_role.rds_role.name
  policy_arn = aws_iam_policy.rds_policy.arn
}

# Associate the IAM role with the RDS instance
resource "aws_db_instance_role_association" "rds_role_association" {
  db_instance_identifier = aws_db_instance.default.id
  feature_name           = "S3_INTEGRATION"
  role_arn               = aws_iam_role.rds_role.arn
}
