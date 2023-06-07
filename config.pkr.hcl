packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-clone" "pouet" {
    # ID
    task_timeout = "15m"
    clone_vm = "pouet"
    proxmox_url = "http://10.27.0.100:8006/api2/json"
    username = "GregoryB@pve!packer"
    token = "e9028361-825e-48be-abb0-a49c3436a468"
    node = "Grp1-Srv1"
    insecure_skip_tls_verify = true    
    # Base ISO File configuration
    # System
    vm_name  = "YEAH" 
    vm_id  = "910"
    ssh_password         = "root"
    ssh_timeout          = "20m"
    ssh_username         = "root"
    
    
    }

build {
    # Load iso configuration
   sources = ["source.proxmox-clone.pouet"]
   
   provisioner "shell" {
    inline = [
    "hostnamectl set-hostname YEAH",
    "echo \"GregoryB ALL=(ALL) NOPASSWD:ALL\" | tee /etc/sudoers.d/GregoryB",
    "mkdir -p /home/bridou/.ssh/",
    "echo \"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClT+lQmJvwPIcgoxvTRuGs7Enls4R3iv1YKn+/fWqHlluOIkRLSUpT5h/IzBlxIEiE781JVJERom+dDNaTi4pyFdtL6p7VD7C9CCMnRMqONBvsX2F+o1+mJK5oKJeJTYa+q9uS/uUNazehK4+PnnZQoviCGhHqpcjv7FBhnhEuAmTjQ1LVOR14S/SSKWHAd6RqsjvtgFWE8S3UjduBbSQzA5QSZEttvsX+QMLofbZh5hr9EErJD/IJjMkFdG+I/V7Xf9d8pvoexti1kzqM+h8GHwQTmmc5hLe3zNZzaT4bDXUQpv9yEw26HuwSyGCIKnIj8CTSi5WQDqmnaU0kpmsZ= GregoryB@GregoryB \" >/home/bridou/.ssh/authorized_keys",
    "apt-get update",
    "apt-get install -y git",
    "mkdir -p /opt/git",
    "cd /opt/git",
    "git init --bare myrepo.git",
    "git config --global user.name \"$GBridou\"",
    "git config --global user.email \"$git_email\"",
    "chown -R bridou:bridou /opt/git",
    "echo 'git_server: /opt/git/myrepo.git' >> /etc/packer-variables.txt",
    ]
  }
}
