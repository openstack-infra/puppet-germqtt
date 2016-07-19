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
  package {'germqtt':
    ensure   => latest,
    provider => 'pip',
    require  => Class['pip'],
  }
}
