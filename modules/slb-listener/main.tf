resource "alicloud_slb_listener" "this" {

  load_balancer_id = var.slb_load_balancer_id
  server_group_id  = var.slb_server_group_id

  frontend_port = var.listeners.frontend_port
  protocol      = var.listeners.protocol
  backend_port  = var.listeners.backend_port
  bandwidth     = var.listeners.bandwidth
  scheduler     = var.listeners.scheduler

  // Health Check
  health_check              = var.health_check_config.health_check
  healthy_threshold         = var.health_check_config.healthy_threshold
  unhealthy_threshold       = var.health_check_config.unhealthy_threshold
  health_check_timeout      = var.health_check_config.health_check_timeout
  health_check_interval     = var.health_check_config.health_check_interval
  health_check_connect_port = var.health_check_config.health_check_connect_port
  health_check_domain       = var.health_check_config.health_check_domain
  health_check_uri          = var.health_check_config.health_check_uri
  health_check_http_code    = var.health_check_config.health_check_http_code
  health_check_type         = var.health_check_config.health_check_type
  health_check_method       = var.health_check_config.health_check_method


  // Advance setting
  sticky_session      = var.advanced_setting.sticky_session
  sticky_session_type = var.advanced_setting.sticky_session_type
  cookie              = var.advanced_setting.cookie
  cookie_timeout      = var.advanced_setting.cookie_timeout
  gzip                = var.advanced_setting.gzip
  persistence_timeout = var.advanced_setting.persistence_timeout
  established_timeout = var.advanced_setting.established_timeout
  acl_status          = var.advanced_setting.acl_status
  acl_type            = var.advanced_setting.acl_type
  acl_id              = var.advanced_setting.acl_id
  idle_timeout        = var.advanced_setting.idle_timeout
  request_timeout     = var.advanced_setting.request_timeout

  // x_forwarded_for setting
  x_forwarded_for {
    retrive_slb_ip    = var.x_forwarded_for_config.retrive_slb_ip
    retrive_slb_id    = var.x_forwarded_for_config.retrive_slb_id
    retrive_slb_proto = var.x_forwarded_for_config.retrive_slb_proto
  }

  // Ssl certificate setting
  server_certificate_id = var.ssl_certificates_config.server_certificate_id
  tls_cipher_policy     = var.ssl_certificates_config.tls_cipher_policy
  enable_http2          = var.ssl_certificates_config.enable_http2
}
