# == Class: germqtt
#
# Full description of class germqtt here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class germqtt {
  include ::pip

  package {'germqtt':
    ensure   => '0.1.0',
    provider => 'pip',
    require  => Class['pip'],
  }
}
