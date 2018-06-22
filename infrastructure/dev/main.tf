/*
  ECS Service definition with its dependencies
*/

module "stepstone-techradar" {
  source = "git::ssh://git@github.com/trufa-me/terraformers.git//modules/ecs_service?ref=ecs_service-latest"

  service_name   = "stepstone-techradar"
  cluster_type   = "general-purpose" # Options - ["memory-optimized" or "general-purpose"] choose depending on workload type - if it's memory heavy choose memory-optimized, if you now sure - choose general purpose
  container_port = "80"
  image_tag      = "dev-latest"
  alb_listener_rule_priority = "41522" # "priority" must be in the range 1-99999

  # Service resource allocation
  #cpu = "0" # The number of cpu units to reserve for the container - https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html
  memory = "1024" # memory allocation for single service container
  desired_count = "2" # Desired count of service containers

  # Service to loadbalancer registration - configuration options
  #deregistration_delay = "10" # The amount time for ALB to wait before changing the state of a deregistering target from draining to unused
  #tg_health_check_path = "/" # health check endpoint
  #tg_health_check_matcher = "200-499" # health check http code matcher
  #tg_health_healthy_threshold = "2" # healthy threshold count
  #tg_health_unhealthy_threshold = "8" # unhealthy threshold count
  #tg_health_timeout = "15" # timeout for single health check request in seconds
  #tg_health_interval = "30" # interval between health check requests in seconds

  # terraform chained parameters
  tf_state_key    = "dev_env_dev_common.tfenv"
}

/*
  Additional configurations
*/


 // This module requires specific terraform version
 module "terraform_version" {
   source = "git::ssh://git@github.com/trufa-me/terraformers.git//modules/terraform_version?ref=terraform_version-0.10.7"
 }
 // Terraform state file specific for service
 terraform {
     backend "s3" {
     bucket = "terraform-state-stepweb-dev"
       key    = "services/stepstone-techradar.tfenv"
       region = "eu-west-1"
     }
 }
