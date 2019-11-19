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
  source = "git::git@github.com:ideasculptor/gcloud-templates.git//subnets?ref=v0.0.10"
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
      subnet_name           = "admin"
      subnet_ip             = "10.1.0.0/24"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    { 
      subnet_name           = "public"
      subnet_ip             = "10.10.10.0/24"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
  ]
}

