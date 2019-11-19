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
  source = "git::git@github.com:ideasculptor/gcloud-templates.git//subnets?ref=v0.0.9"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = [
    "../../../../root-folder",
    "../../../environment"
  ]
}

inputs = {
  delete_default_internet_gateway_routes = "false"

  subnets          = [
    { 
      subnet_name           = "gke"
      subnet_ip             = "10.10.11.0/24"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    { 
      subnet_name           = "cloud-sql"
      subnet_ip             = "10.10.12.0/24"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
  ]

  secondary_ranges = {
    gke = [
      {
        range_name = "services"
        ip_cidr_range = "192.168.0.0/22"
      },
      {
        range_name = "pods"
        ip_cidr_range = "192.168.16.0/20"
      },
    ]
  }
}

