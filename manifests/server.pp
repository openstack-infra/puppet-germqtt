# Copyright 2016 Hewlett-Packard Development Company, L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#         
#      http://www.apache.org/licenses/LICENSE-2.0
#         
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# == Class: germqtt::server
#   

class germqtt::server (
 gerrit_username,
 gerrit_hostname = review.openstack.org,
 gerrit_key,
 mqtt_hostname = firehose01.openstack.org,
 topic = gerrit
) {
  file { '/etc/germqtt.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    content => template('germqtt/germqtt.conf.erb')
  }
  file { '/etc/systemd/system/germqtt.service':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    content => template('germqtt/germqtt.service.erb')
  }
  user { 'germqtt':
    ensure => present,
    system => true,
  }
  service { "germqtt":
    enable     => true,
    hasrestart => true,
    subscribe  => [
      File['/etc/germqtt/germqtt.conf'],
      Package['germqtt'],
    ],
    require    => [
      File['/etc/systemd/system/germqtt.service']
      User['germqtt'],
    ],
  }
}
