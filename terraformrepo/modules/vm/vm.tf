resource "azurerm_virtual_machine" "vm" {
  count = 2
  name                  = "webvm${count.index}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [element(nic, count.index)]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "webserver"
    admin_username = "azureuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("~./id_rsa.pub")
      path = "/home/{username}/.ssh/authorized_keys"
    }
  }
  tags = {
    environment = ""
  }
}

resource "null_resource" "apiapp" {
  provisioner "local-exec" {
    command = "/usr/bin/sh route.sh ${var.webapp_test}"
  }

}