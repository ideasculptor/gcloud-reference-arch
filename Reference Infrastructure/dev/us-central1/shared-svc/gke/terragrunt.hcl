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
  source = "git::git@github.com:ideasculptor/gcloud-templates.git//gke?ref=v0.0.5"
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
  master_authorized_networks_config = [{
    cidr_blocks = [{
      cidr_block = "98.232.147.100/32"
      display_name = "home"
    }]
  }]
  regional = false
  zones = ["us-central1-a"]
}

