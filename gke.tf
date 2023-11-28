resource "random_integer" "zone" {
  count = (var.zone == null ? 1 : 0)

  min = 0
  max = length(data.google_compute_zones.available.names)
}

locals {
  zone = (
    var.zone != null ?
    var.zone :
    element(
      data.google_compute_zones.available.names,
      random_integer.zone[0].result
    )
  )
}

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = local.zone

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = true
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-worker-pool"
  location   = local.zone
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
