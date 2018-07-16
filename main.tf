# Terraform Main

module "domain" {
  source = "git::https://github.com/nalbam/terraform-aws-route53.git"
  domain = "${var.domain}"
}

module "demo-api" {
  source = "git::https://github.com/nalbam/terraform-aws-lambda-api.git"
  region = "${var.region}"

  name         = "${var.name}"
  stage        = "${var.stage}"
  description  = "route53 > api gateway > ${var.name}"
  runtime      = "nodejs8.10"
  handler      = "index.handler"
  memory_size  = 512
  timeout      = 5
  s3_bucket    = "${var.s3_bucket}"
  s3_source    = "target/lambda.zip"
  s3_key       = "lambda/${var.name}/${var.name}-${var.version}.zip"
  http_methods = ["ANY"]

  zone_id         = "${module.domain.zone_id}"
  certificate_arn = "${module.domain.certificate_arn}"
  domain_name     = "${var.name}-${var.stage}.${var.domain}"

  env_vars = {
    PROFILE = "${var.stage}"
  }
}
