resource "aws_iam_role" "ecs_task_execution_role" {
  name = var.ecs_task_exec_role_name

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role" "ecs_task_role" {
  name = var.ecs_task_role_name

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "task_s3" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}





###########################################


data "aws_iam_policy_document" "assume_by_codebuild" {
  statement {
    sid     = "AllowAssumeByCodebuild"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild" {
  name               = "test-codebuild"
  assume_role_policy = data.aws_iam_policy_document.assume_by_codebuild.json
}

data "aws_iam_policy_document" "codebuild" {
  statement {
    sid    = "AllowS3"
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowECR"
    effect = "Allow"

    actions = [
      "ecr:*"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AWSKMSUse"
    effect = "Allow"

    actions = [
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:Encrypt",
      "kms:ReEncrypt*",
      "kms:Decrypt"
    ]

    resources = ["*"]
  }

  statement {
    sid       = "AllowECSDescribeTaskDefinition"
    effect    = "Allow"
    actions   = ["ecs:DescribeTaskDefinition"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowLogging"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "codebuild" {
  role   = aws_iam_role.codebuild.name
  policy = data.aws_iam_policy_document.codebuild.json
}


##  Create Certificate for LB

resource "aws_iam_server_certificate" "test_cert" {
  name_prefix      = "selfsign-cert"
  certificate_body = file("../Cert/cert.pem")
  private_key      = file("../Cert/Private.key")

  lifecycle {
    create_before_destroy = true
  }
}


//#######################
//
//#Rol for CodePipeline
//
//resource "aws_iam_role" "codepipeline_role" {
//  name = "code-pipeline-rol"
//
//  assume_role_policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Effect": "Allow",
//      "Principal": {
//        "Service": "codepipeline.amazonaws.com"
//      },
//      "Action": "sts:AssumeRole"
//    }
//  ]
//}
//EOF
//}
//
//resource "aws_iam_role_policy" "codepipeline_policy" {
//  name = "codepipeline_policy"
//  role = aws_iam_role.codepipeline_role.id
//
//  policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Effect":"Allow",
//      "Action": [
//        "s3:GetObject",
//        "s3:GetObjectVersion",
//        "s3:GetBucketVersioning",
//        "s3:PutObject"
//      ],
//      "Resource": ["*"]
//    },
//    {
//      "Effect": "Allow",
//      "Action": [
//        "codebuild:BatchGetBuilds",
//        "codebuild:StartBuild"
//      ],
//      "Resource": "*"
//    }
//  ]
//}
//EOF
//}
