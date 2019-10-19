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
  source = "git::git@github.com:ideasculptor/gcloud-templates.git//environment?ref=v0.0.2"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = [
    "../../root-folder"
  ]
}

inputs = {
  gsuite_credentials = "/Users/sgendler/Downloads/service-accounts-256205-46bc86d3a3b1.json"
  impersonate_gsuite_user = "sgendler@ideasculptor.com"

  admin_members = [
    "sgendler@ideasculptor.com"
  ]
  admin_members_num = 1
}

