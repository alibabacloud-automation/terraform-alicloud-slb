module "slb" {
  source = "../.."

  create_slb_listener = true
  listener_config = [{
    listeners = {
      backend_port  = "80"
      frontend_port = "80"
      protocol      = "http"
      bandwidth     = "-1"
    }
  }]
}

resource "alicloud_slb_server_group" "default" {
  load_balancer_id = module.slb.this_slb_id
}

module "example" {
  source = "../.."

  create = false

  create_slb_rule = true
  rule_config = [{
    load_balancer_id          = module.slb.this_slb_id
    server_group_id           = alicloud_slb_server_group.default.id
    frontend_port             = module.slb.this_slb_listener_frontend_port[0]
    name                      = var.name
    cookie_timeout            = var.cookie_timeout
    health_check_connect_port = var.health_check_connect_port
    domain                    = "*.aliyun.com"
    url                       = "/image"
    cookie                    = var.cookie
    health_check_timeout      = var.health_check_timeout
    unhealthy_threshold       = var.unhealthy_threshold
    scheduler                 = var.scheduler
    health_check_domain       = var.health_check_domain
    health_check              = var.health_check
  }]
}
