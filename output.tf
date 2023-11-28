output "ca" {
  value = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}

output "client_key" {
  value = google_container_cluster.primary.master_auth[0].client_key
}

output "client_certificate" {
  value = google_container_cluster.primary.master_auth[0].client_certificate
}

output "endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "copy_and_paste" {
  value = "gcloud container clusters get-credentials my-gke-cluster --zone europe-west2-c &&  kubectl config set-cluster $(kubectl config current-context) --insecure-skip-tls-verify=true"

}
