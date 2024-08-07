resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_zones" "default" {
}

data "alicloud_images" "default" {
  name_regex = "^centos_6"
}

data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_slb_acl" "default" {
  name       = "${var.name}-${random_integer.default.result}"
  ip_version = "ipv4"
}

resource "alicloud_slb_server_certificate" "default" {
  name               = var.name
  server_certificate = "-----BEGIN CERTIFICATE-----\nMIICWDCCAcGgAwIBAgIJAP7vOtjPtQIjMA0GCSqGSIb3DQEBCwUAMEUxCzAJBgNV\nBAYTAkNOMRMwEQYDVQQIDApjbi1iZWlqaW5nMSEwHwYDVQQKDBhJbnRlcm5ldCBX\naWRnaXRzIFB0eSBMdGQwHhcNMjAxMDIwMDYxOTUxWhcNMjAxMTE5MDYxOTUxWjBF\nMQswCQYDVQQGEwJDTjETMBEGA1UECAwKY24tYmVpamluZzEhMB8GA1UECgwYSW50\nZXJuZXQgV2lkZ2l0cyBQdHkgTHRkMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKB\ngQDEdoyaJ0kdtjtbLRx5X9qwI7FblhJPRcScvhQSE8P5y/b/T8J9BVuFIBoU8nrP\nY9ABz4JFklZ6SznxLbFBqtXoJTmzV6ixyjjH+AGEw6hCiA8Pqy2CNIzxr9DjCzN5\ntWruiHqO60O3Bve6cHipH0VyLAhrB85mflvOZSH4xGsJkwIDAQABo1AwTjAdBgNV\nHQ4EFgQUYDwuuqC2a2UPrfm1v31vE7+GRM4wHwYDVR0jBBgwFoAUYDwuuqC2a2UP\nrfm1v31vE7+GRM4wDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQsFAAOBgQAovSB0\n5JRKrg7lYR/KlTuKHmozfyL9UER0/dpTSoqsCyt8yc1BbtAKUJWh09BujBE1H22f\nlKvCAjhPmnNdfd/l9GrmAWNDWEDPLdUTkGSkKAScMpdS+mLmOBuYWgdnOtq3eQGf\nt07tlBL+dtzrrohHpfLeuNyYb40g8VQdp3RRRQ==\n-----END CERTIFICATE-----"
  private_key        = "-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQDEdoyaJ0kdtjtbLRx5X9qwI7FblhJPRcScvhQSE8P5y/b/T8J9\nBVuFIBoU8nrPY9ABz4JFklZ6SznxLbFBqtXoJTmzV6ixyjjH+AGEw6hCiA8Pqy2C\nNIzxr9DjCzN5tWruiHqO60O3Bve6cHipH0VyLAhrB85mflvOZSH4xGsJkwIDAQAB\nAoGARe2oaCo5lTDK+c4Zx3392hoqQ94r0DmWHPBvNmwAooYd+YxLPrLMe5sMjY4t\ndmohnLNevCK1Uzw5eIX6BNSo5CORBcIDRmiAgwiYiS3WOv2+qi9g5uIdMiDr+EED\nK8wZJjB5E2WyfxL507vtW4T5L36yfr8SkmqH3GvzpI2jCqECQQDsy0AmBzyfK0tG\nNw1+iF9SReJWgb1f5iHvz+6Dt5ueVQngrl/5++Gp5bNoaQMkLEDsy0iHIj9j43ji\n0DON05uDAkEA1GXgGn8MXXKyuzYuoyYXCBH7aF579d7KEGET/jjnXx9DHcfRJZBY\nB9ghMnnonSOGboF04Zsdd3xwYF/3OHYssQJAekd/SeQEzyE5TvoQ8t2Tc9X4yrlW\nxNX/gmp6/fPr3biGUEtb7qi+4NBodCt+XsingmB7hKUP3RJTk7T2WnAC5wJAMqHi\njY5x3SkFkHl3Hq9q2CKpQxUbCd7FXqg1wum/xj5GmqfSpNjHE3+jUkwbdrJMTrWP\nrmRy3tQMWf0mixAo0QJBAN4IcZChanq8cZyNqqoNbxGm4hkxUmE0W4hxHmLC2CYZ\nV4JpNm8dpi4CiMWLasF6TYlVMgX+aPxYRUWc/qqf1/Q=\n-----END RSA PRIVATE KEY-----"
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_cidr           = "172.16.0.0/12"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.zones.0.id]
}

module "security_group" {
  source = "alibaba/security-group/alicloud"
  vpc_id = module.vpc.this_vpc_id
}

// ECS Module
module "ecs_instance" {
  source = "alibaba/ecs-instance/alicloud"

  number_of_instances = 1

  instance_type               = data.alicloud_instance_types.default.instance_types.0.id
  image_id                    = data.alicloud_images.default.images.0.id
  vswitch_ids                 = [module.vpc.this_vswitch_ids[0]]
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = false
  system_disk_category        = "cloud_ssd"
  system_disk_size            = var.system_disk_size
}

module "slb_listener" {
  source = "../../"

  # slb
  servers_of_virtual_server_group = [
    {
      server_ids = module.ecs_instance.this_instance_id[0]
      port       = var.port
      weight     = var.weight
      type       = "ecs"
    },
  ]

  # slb listener
  create_slb_listener = true
  listener_config = [{
    listeners = {
      backend_port  = "80"
      frontend_port = "80"
      protocol      = "http"
      bandwidth     = var.bandwidth
      scheduler     = var.scheduler
    }
    health_check_config = {
      health_check              = var.health_check
      healthy_threshold         = var.healthy_threshold
      unhealthy_threshold       = var.unhealthy_threshold
      health_check_timeout      = var.health_check_timeout
      health_check_interval     = var.health_check_interval
      health_check_connect_port = var.health_check_connect_port
      health_check_domain       = var.health_check_domain
      health_check_uri          = var.health_check_uri
      health_check_http_code    = var.health_check_http_code
      health_check_type         = var.health_check_type
      health_check_method       = var.health_check_method
    }
    advanced_setting = {
      sticky_session      = var.sticky_session
      sticky_session_type = var.sticky_session_type
      cookie              = var.cookie
      cookie_timeout      = var.cookie_timeout
      gzip                = var.gzip
      persistence_timeout = var.persistence_timeout
      established_timeout = var.established_timeout
      acl_status          = var.acl_status
      acl_type            = var.acl_type
      acl_id              = alicloud_slb_acl.default.id
      idle_timeout        = var.idle_timeout
      request_timeout     = var.request_timeout
    }
    x_forwarded_for_config = {
      retrive_slb_ip    = var.retrive_slb_ip
      retrive_slb_id    = var.retrive_slb_id
      retrive_slb_proto = var.retrive_slb_proto
    }
    ssl_certificates_config = {
      server_certificate_id = alicloud_slb_server_certificate.default.id
      tls_cipher_policy     = var.tls_cipher_policy
      enable_http2          = var.enable_http2
    }
  }]

}
