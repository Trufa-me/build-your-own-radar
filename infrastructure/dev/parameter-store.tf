variable "parameter_store_kms" {
  default = "arn:aws:kms:eu-west-1:796467622059:key/5985b7a3-1258-40da-87be-875341522621ccb"
}
/*
  Application specific parameters
*/
/* e.g.
resource "aws_ssm_parameter" "generic_service_api_password" {
  name  = "/generic_service/security/generic_service_api_password"
  type  = "SecureString"
  value = "<secret>"
  key_id  = "${var.parameter_store_kms}"
  lifecycle { ignore_changes = ["value"] }
  overwrite = "true"

  tags {
    Role = "${module.stepstone-techradar.service_name}"
  }
}

resource "aws_ssm_parameter" "generic_service_api_setting" {
  name  = "/generic_service/settings/value"
  type  = "String"
  value = "1234-5678"
  overwrite = "true"
  tags {
    Role = "${module.stepstone-techradar.service_name}"
  }
}
*/
