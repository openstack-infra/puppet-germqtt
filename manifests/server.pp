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
  $gerrit_username,
  $gerrit_hostname = 'review.openstack.org',
  $gerrit_public_key,
  $gerrit_private_key,
  $gerrit_ssh_host_key = undef,
  $mqtt_hostname = 'firehose01.openstack.org',
  $topic = 'gerrit',
  $pid_file = '/var/run/germqtt.pid',
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
  group {'germqtt':
    ensure => present,
  }

  user { 'germqtt':
    ensure     => present,
    home       => '/home/germqtt',
    shell      => '/bin/bash',
    gid        => 'germqtt',
    managehome => true,
    require    => Group['germqtt'],
  }

  file {'/home/germqtt':
    ensure  => directory,
    mode    => '0700',
    owner   => 'germqtt',
    group   => 'germqtt',
    require => User['germqtt'],
  }

  file {'/home/germqtt/.ssh':
    ensure  => directory,
    mode    => '0700',
    owner   => 'germqtt',
    group   => 'germqtt',
    require => File['/home/germqtt'],
  }

  file {'/home/germqtt/.ssh/id_rsa.pub':
    ensure  => present,
    owner   => 'germqtt',
    group   => 'germqtt',
    mode    => '0600'.
    content => $gerrit_public_key,
    replace => true,
    require => File['/home/germqtt/.ssh/']
  }

  file {'/home/germqtt/.ssh/id_rsa':
    ensure  => present,
    owner   => 'germqtt',
    group   => 'germqtt',
    mode    => '0600'.
    content => $gerrit_private_key,
    replace => true,
    require => File['/home/germqtt/.ssh/']
  }

  if $gerrit_ssh_host_key != undef {
    file {'/home/germqtt/.ssh/known_hosts':
      ensure  => present,
      owner   => 'germqtt',
      group   => 'germqtt',
      mode    => '0600'.
      content => $gerrit_ssh_host_key,
      replace => true,
      require => File['/home/germqtt/.ssh/']
    }
  }

  service { 'germqtt':
    enable     => true,
    hasrestart => true,
    subscribe  => [
      File['/etc/germqtt.conf'],
      Package['germqtt'],
    ],
    require    => [
      File['/etc/systemd/system/germqtt.service'],
      User['germqtt'],
    ],
  }
}
