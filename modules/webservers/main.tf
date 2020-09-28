# terraform{
#     required_version = ">= 0.12"
# }

resource "digitalocean_droplet" "web" {
  for_each = {
        prod = "blr1"
        dev = "fra1"
  }
  image  = "ubuntu-20-04-x64"
  name   = "web-${each.key}"
  region = "${each.value}"
  size   = "s-1vcpu-1gb"
  tags = var.droplet_tags
  ssh = ${ssh_key}

  lifecycle{
      create_before_destroy = true
  }
}

locals{
    source_addr = ["0.0.0.0/0", "::0/0"]
}

locals{
    inbound_rules = [{
        protocol = "tcp"
        port     = "80"
    },
    {
        protocol = "tcp"
        port     = "443"
    }]
}

locals{
    outbound_rules = [
        {
            protocol = "tcp"
            port     = "80"
        },
        {
            protocol = "tcp"
            port     = "443"
        }
    ]
}

# resource "digitalocean_firewall" "prod_env"{
#     name  = "Only-http-and-https"

#     droplet_ids = [for web in digitalocean_droplet.web.*.id: web]

#     dynamic "inbound_rule" {
#         for_each = local.inbound_rules

#         content{
#             protocol    = inbound_rule.value.protocol
#             port_range  = inbound_rule.value.port
#             source_addresses = local.source_addr
#         }
#     }

#     dynamic "outbound_rule"{
#         for_each = local.outbound_rules

#         content {
#             protocol  = outbound_rule.value.protocol
#             port_range = outbound_rule.value.port
#             destination_addresses = local.source_addr
#         }

#     }
# }