variable "parameter_store_kms" {
  default = "arn:aws:kms:eu-west-1:203131541522539:key/8522fbbf-e42d-4fbb-8d59-86d340c9a5e2"
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
}
*/
