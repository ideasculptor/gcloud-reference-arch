# gcloud reference architecture implementation
# Copyright (C) 2019 Samuel Gendler
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

terraform {
  source = "git::git@github.com:ideasculptor/gcloud-templates.git//gke?ref=v0.0.8"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = [
    "../../../../root-folder",
    "../../../environment",
    "../../dev/backend_subnets",
  ]
}

inputs = {
  subnets_path = "backend_subnets"

  master_ipv4_cidr_block  = "172.16.0.0/28"

  regional = false
  zones = ["us-central1-a"]
  # initial_node_count = 1
  remove_default_node_pool = true
  disable_legacy_metadata_endpoints = false

  // optional features
  kubernetes_dashboard = true
  http_load_balancing = true
  cloudrun = true
  enable_shielded_nodes = true
  enable_intranode_visibility = false
  enable_binary_authorization = false
  enable_vertical_pod_autoscaling = true
  istio = true
  deploy_using_private_endpoint = false
  enable_private_endpoint = true
  enable_private_nodes = true
  create_service_account = true
  use_project_service_account = false
  grant_registry_access = true

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "n1-standard-2"
      node_locations     = "us-central1-a"
      min_count          = 1
      max_count          = 100
      disk_size_gb       = 50
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = false
      preemptible        = false
      initial_node_count = 1
    },
  ]

  node_pools_labels = {
    all = {}
    default-node-pool = {}
  }

  node_pools_metadata = {
    all = {}
    default-node-pool = {}
  }

  node_pools_taints = {
    all = []
    default-node-pool = []
  }

  node_pools_tags = {
    all = ["ssh", "https"]
    default-node-pool = []
  }

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
    ]
    default-node-pool = [
    ]
  }
}

