terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

locals   {
    folder_id   = "b1gbve7tetqnhc1k5b03"
    cloud_id = "b1gq508pbil6f7tsqpdq"
}

provider "yandex" {
  cloud_id = local.cloud_id
  folder_id = local.folder_id
  service_account_key_file = "/home/dima/terraform/authorized_key.json"
  zone = "ru-central1-d"

}