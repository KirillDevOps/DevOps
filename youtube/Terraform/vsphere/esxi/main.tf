provider "vsphere" {
  vsphere_server = var.vsphere_server
  user           = var.vsphere_user
  password       = var.vsphere_password

  # If you have a self-signed cert
  allow_unverified_ssl = true
}


data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

//data "vsphere_compute_cluster" "cluster" {
//  name          = var.cluster
//  datacenter_id = data.vsphere_datacenter.dc.id
//}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.network_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "esxi" {
  name          = var.esxi
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "/${var.datacenter}/vm/${var.template_name}"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "windows_srv_2016_tf" {
  count = 2
  name             = "windows_srv_2016_tf"
  resource_pool_id = data.vsphere_host.esxi.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 4
  memory   = 8192

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  wait_for_guest_net_timeout = -1
  wait_for_guest_ip_timeout  = -1

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  guest_id         = data.vsphere_virtual_machine.template.guest_id

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = true
  }
}

output "vm_ip_0" {
  value = vsphere_virtual_machine.windows_srv_2016_tf[0].guest_ip_addresses
}

output "vm_ip_1" {
  value = vsphere_virtual_machine.windows_srv_2016_tf[1].guest_ip_addresses
}