terraform {

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "reddit-app-bucket"
    region     = "ru-central1"
    key        = "prod/terraform.tfstate"
    access_key = "aaaaaaaaaaaaaaa"
    secret_key = "key.json"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token     = "service_account_key>"
  cloud_id  = "cloudid"
  folder_id = "folderid"
  zone      = "zoneid"
}

