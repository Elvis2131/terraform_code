provider "digitalocean" {
    token = var.do_token
}

locals{
    tag = "samira"

}

data "digitalocean_ssh_key" "main"{
    name = "Main Machine"
}

//Locals is for declaring variables inside of a module, not intended for a global scope. You call it by local.<var-name>

module "droplet_create"{
    source = "./modules/webservers"
    droplet_tags = var.droplet_tags
    for_each     = var.droplet_location
    ssh_key      = data.digitalocean_ssh_key
}


