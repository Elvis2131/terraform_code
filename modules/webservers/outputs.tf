# output "server_ip" {
#     value = digitalocean_droplet.web.*.ipv4_address
# }

# output "server_id"{
#     value = [for instance in digitalocean_droplet.web: instance.id]
# }