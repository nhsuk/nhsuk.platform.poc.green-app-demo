terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource "random_pet" "app_name" {
  length = 4
}

output "app_name" {
  value = "rg-${random_pet.app_name.id}"
}
