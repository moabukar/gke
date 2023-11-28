terraform {
  backend s3 {
    bucket  = "aws-docker-demo"
    key     = "gcp-gke/terraform.tfstate"
    region  = "eu-west-2"
  }
}

provider "google" {
  credentials = var.account
  project     = var.project
  region      = var.region
}

resource "random_string" "prefix" {
  count = (var.name_prefix == null ? 1 : 0)

  length  = 7
  lower   = true
  upper   = false
  number  = false
  special = false
}

locals {
  default_prefix = "kubernetes-the-easy-way"

  name_prefix = (
    # check if specified a prefix
    var.name_prefix != null ?
    (
      # check if want specified or default prefix
      var.name_prefix == "" ?
      local.default_prefix : # use default prefix
      var.name_prefix        # use specified prefix
    ) :
    # automatically generate a random prefix
    format(
      "%s-%s",
      local.default_prefix,
      random_string.prefix[0].result
    )
  )
}
