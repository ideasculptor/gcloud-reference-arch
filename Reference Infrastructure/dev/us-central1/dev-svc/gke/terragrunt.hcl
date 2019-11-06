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
  source = "git::git@github.com:ideasculptor/gcloud-templates.git//gke?ref=v0.0.6"
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
  authorized_cidr_blocks = []
/*
  [{
    cidr_block = "98.232.147.100/32"
    display_name = "home"
  }]
*/
  regional = false
  zones = ["us-central1-a"]
  # initial_node_count = 1
  # remove_default_node_pool = false

  // optional features
  kubernetes_dashboard = false
  http_load_balancing = false
  cloudrun = false
  enable_intranode_visibility = false
  enable_binary_authorization = false
  enable_vertical_pod_autoscaling = false
  istio = false
  // deploy_using_private_endpoint = false
  enable_private_endpoint = true
  enable_private_nodes = true
  create_service_account = true
  use_project_service_account = false
  grant_registry_access = false

/*
  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "n1-standard-1"
      min_count          = 1
      max_count          = 100
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
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
    all = ["ssh"]
    default-node-pool = []
  }

  node_pools_oauth_scopes = {
    all = ["https://www.googleapis.com/auth/cloud-platform"]
    default-node-pool = []
  }
*/
}

