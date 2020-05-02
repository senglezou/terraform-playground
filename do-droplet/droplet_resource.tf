data "digitalocean_ssh_key" "tf-test-1-key" {
  name = var.do_ssh_key
}

resource "digitalocean_droplet" "freebsd" {
  image  = "freebsd-12-x64-zfs"
  name   = "tf-test-1"
  region = "lon1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.tf-test-1-key.id]
}
