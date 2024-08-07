resource "alicloud_slb_rule" "default" {
  load_balancer_id          = var.load_balancer_id
  frontend_port             = var.frontend_port
  server_group_id           = var.server_group_id
  name                      = var.name
  domain                    = var.domain
  url                       = var.url
  cookie                    = var.cookie
  cookie_timeout            = var.cookie_timeout
  health_check_http_code    = var.health_check_http_code
  health_check_interval     = var.health_check_interval
  health_check_uri          = var.health_check_uri
  health_check_connect_port = var.health_check_connect_port
  health_check_timeout      = var.health_check_timeout
  healthy_threshold         = var.healthy_threshold
  unhealthy_threshold       = var.unhealthy_threshold
  sticky_session            = var.sticky_session
  sticky_session_type       = var.sticky_session_type
  listener_sync             = var.listener_sync
  scheduler                 = var.scheduler
  health_check_domain       = var.health_check_domain
  health_check              = var.health_check
}
