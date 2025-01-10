# Используем существующую сеть по умолчанию
data "yandex_vpc_network" "default" {
  name = "default"
}

# Используем существующую подсеть по умолчанию
data "yandex_vpc_subnet" "default" {
  name = "default-ru-central1-d"
}

# Создаем инстанс
resource "yandex_compute_instance" "runner" {
  name        = "github-runner"
  platform_id = "standard-v2"
  zone        = "ru-central1-d"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd81hgrcv6lsnkremf32" # Ubuntu 20.04
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.default.id # Используем подсеть по умолчанию
    nat       = true                              # Включаем NAT для доступа в интернет
  }

  metadata = {
    user-data = <<-EOT
      #cloud-config
      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: no
      users:
      - name: dima
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        shell: /bin/bash
        ssh_authorized_keys:
        - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/1JbX6alYyleTMFEmT8DvoeoaDAwlgdoAWFOZl6o+h Дмитрий@Home
      runcmd:
        - mkdir /opt/runner
        - cd /opt/runner
        - curl -o actions-runner-linux-x64-2.321.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.321.0/actions-runner-linux-x64-2.321.0.tar.gz
        - tar xzf ./actions-runner-linux-x64-2.321.0.tar.gz
        - chown -R dima:dima /opt/runner
        - sudo -u dima ./config.sh --url https://github.com/Mo3goeff/terraform --token BNSIWV5NCDHILF7WSSIL5HLHO2NH4
        - sudo -u dima ./run.sh
    EOT
  }
}
