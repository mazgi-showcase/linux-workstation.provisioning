resource "google_dns_managed_zone" "main" {
  name     = var.project_unique_id
  dns_name = "${var.base_dnsdomain}."
  dnssec_config {
    state = "on"
  }
}
