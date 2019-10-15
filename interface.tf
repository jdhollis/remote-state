variable "prefix" {}

variable "region" {
  default = "us-east-1"
}

output "env" {
  value = {
    tools = module.tools.outputs
    dev   = module.dev.outputs
    stage = module.stage.outputs
    prod  = module.prod.outputs
  }
}

output "region" {
  value = var.region
}
