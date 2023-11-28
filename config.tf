data "template_file" "kubeconfig" {
  template = file("${path.module}/templates/kubeconfig.yaml.template")

  vars = {
    ca           = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
    endpoint     = google_container_cluster.primary.endpoint
  }
}

resource "local_file" "kubeconfig" {
   content  = "${data.template_file.kubeconfig.rendered}"
   filename = "kubeconfig"
}
