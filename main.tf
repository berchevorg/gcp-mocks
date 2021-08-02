variable "gcp_credentials" {}

variable "gcp_project_id" {
  default = "georgiberchev-test-002"
}

provider "google" {
  region      = "us-central1"
  credentials = var.gcp_credentials
  project = var.gcp_project_id
}


resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.custom-test.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_network" "custom-test" {
  name                    = "test-network"
  auto_create_subnetworks = false
}
