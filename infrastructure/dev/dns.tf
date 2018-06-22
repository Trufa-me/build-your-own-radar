/*
  DNS Setup
*/
variable "r53_zone" {
  default = "ZW6IDLJZXY2S9"
}
variable "live_memory_optimized_endpoint" {
  default = "live-memory-optimized-loadbalancer.trufa.me"
}
variable "live_general_purpose_endpoint" {
  default = "live-general-purpose-loadbalancer.trufa.me"
}
variable "dev_memory_optimized_endpoint" {
  default = "dev-memory-optimized-loadbalancer.trufa.me"
}
variable "dev_general_purpose_endpoint" {
  default = "dev-general-purpose-loadbalancer.trufa.me"
}

/*
  Dev endpoints
*/
resource "aws_route53_record" "r53_record_dev" {
  zone_id = "${var.r53_zone}"
  name    = "dev-${module.stepstone-techradar.service_name}.trufa.me"
  type    = "CNAME"
  ttl     = "60"
  records = ["${module.stepstone-techradar.cluster_type == "memory-optimized" ? var.dev_memory_optimized_endpoint : var.dev_general_purpose_endpoint}"]
}
/*
  Live endpoints
*/
resource "aws_route53_record" "r53_record_live" {
  zone_id = "${var.r53_zone}"
  name    = "live-${module.stepstone-techradar.service_name}.trufa.me"
  type    = "CNAME"
  ttl     = "60"
  records = ["${module.stepstone-techradar.cluster_type == "memory-optimized" ? var.live_memory_optimized_endpoint : var.live_general_purpose_endpoint}"]
}

resource "aws_route53_record" "r53_record_live_main" {
  zone_id = "${var.r53_zone}"
  name    = "${module.stepstone-techradar.service_name}.trufa.me"
  type    = "CNAME"
  ttl     = "60"
  records = ["${module.stepstone-techradar.cluster_type == "memory-optimized" ? var.live_memory_optimized_endpoint : var.live_general_purpose_endpoint}"]
}
