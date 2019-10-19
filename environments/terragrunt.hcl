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

remote_state {
  backend = "gcs"
  config = {
    bucket  = "refarch_root_tf_state"
    prefix  = "environments/${path_relative_to_include()}"
    project = "refarch-root-db74"
    location = "us-west1"
  }
}

inputs = merge(
  # Configure Terragrunt to use common vars encoded as yaml to help you keep 
  # often-repeated variables (e.g., account ID) DRY. Use yamldecode to merge
  # the maps into the inputs, as opposed to using varfiles due to a restriction
  # in Terraform >=0.12 that all vars must be defined as variable blocks in
  # modules. Terragrunt inputs are not affected by this restriction.
  yamldecode(
    file("${get_terragrunt_dir()}/${find_in_parent_folders("environment.yaml",
         "${path_relative_from_include()}/empty.yaml")}"),
  ),
  yamldecode(
    file("${get_terragrunt_dir()}/${find_in_parent_folders("region.yaml",
         "${path_relative_from_include()}/empty.yaml")}"),
  ),
  yamldecode(
    file("${get_terragrunt_dir()}/${find_in_parent_folders("project.yaml",
         "${path_relative_from_include()}/empty.yaml")}"),
  ),

  # Additional global inputs to pass to modules called in this directory tree.
  {
    terraform_state_bucket  = "refarch_root_tf_state"
    terraform_state_prefix = "environments"
    folders_state_prefix = "folders"
    organization = "499938684127"
    organization_name = "ideasculptor.com"
    billing_account_id = "016AA8-2A2B8C-B0B16C"
  },
)
