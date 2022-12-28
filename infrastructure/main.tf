
terraform {
  cloud {
    organization = "paretl"

    workspaces {
      name = "lesgourmetsnomades"
    }
  }
}
