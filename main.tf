######
# SLB Instance
######
module "slb" {
  source = "./modules/slb"

  name = var.name

  vswitch_id = var.vswitch_id
  internal   = var.internal

  internet_charge_type = var.internet_charge_type
  bandwidth            = var.bandwidth

  spec = var.spec
}

#################
# SLB attachment
#################
module "slb_attachment" {
  source = "./modules/slb_attachment"

  slb       = module.slb.slb_id
  instances = var.instances
}

