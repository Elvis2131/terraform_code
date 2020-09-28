variable "do_token"{
    type = string
    description = "Digital ocean token key"
}

# ""variable "droplet_tag"{
#     type = object({
#         name = string
#     })
# }""

variable "droplet_tags"{
    type = list(string)
}

variable "droplet_location"{
    type = map(string)
    description = "Droplet locations"
}