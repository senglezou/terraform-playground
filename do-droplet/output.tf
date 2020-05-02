output "droplet_ip" {
  value = digitalocean_droplet.freebsd.ipv4_address
  description = "Droplet IP"
}
