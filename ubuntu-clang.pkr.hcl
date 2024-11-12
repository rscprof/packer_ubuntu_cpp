# ubuntu-clang.pkr.hcl

packer {
  required_plugins {
    virtualbox = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}


source "virtualbox-iso" "ubuntu" {
  iso_url            = "download/ubuntu.iso"
  #Ubuntu desktop 24.04 
  iso_checksum       = "sha256:c2e6f4dc37ac944e2ed507f87c6188dd4d3179bf4a3f9e110d3c88d1f3294bdc"
  # iso_checksum       = "sha256:e240e4b801f7bb68c20d1356b60968ad0c33a41d00d828e74ceb3364a0317be9"
  ssh_username       = "student"
  ssh_password       = "student"
  cpus               = 4 
  memory             = 8192
  disk_size          = 20000
  #Without this don't boot, vmsvga don't work either
  gfx_controller     = "vmsvga"
  gfx_vram_size = 128
  gfx_accelerate_3d = true
  guest_os_type      = "Ubuntu_64"
  #https://cloudinit.readthedocs.io/en/latest/reference/datasources/nocloud.html
  #there is a log of cloud-init in /var/log
  boot_command = ["<wait>e<wait><down><down><down><end><bs><bs><bs><bs> \"ds=nocloud;s=http://{{.HTTPIP}}:{{.HTTPPort}}/\" autoinstall debug ---<wait><f10><wait>"]
  ssh_timeout        = "3h"
  boot_wait          = "10s"
  headless           = false
  http_directory     = "http"
  
  # Modify settings below for your needs
  shutdown_command    = "sudo shutdown now"

  # Specify the output format
  output_directory    = "output-ubuntu-clang"
}

build {
  sources = ["source.virtualbox-iso.ubuntu"]
  provisioner "shell" {
    inline = ["code --install-extension ms-vscode.cpptools"]
  }


  provisioner "shell" {
    inline = [
    #"sudo apt install linux-headers-`uname -r`",
	      "sudo mount -o loop /home/student/VBoxGuestAdditions.iso /mnt; sudo sh /mnt/VBoxLinuxAdditions.run; sudo umount /mnt"]
    valid_exit_codes = [0,2]    
  }
  
  post-processor "shell-local" { 
      inline = [ "rclone copy -P output-ubuntu-clang yandex:/vm_images/ubuntu_c" ]
  }

}
