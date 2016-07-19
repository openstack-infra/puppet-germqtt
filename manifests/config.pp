# == Class: germqtt::config
#
# This class is used to manage arbitrary germqtt configurations.
#
# === Parameters
#
# [*germqtt_config*]
#   (optional) Allow configuration of arbitrary germqtt configurations.
#   The value is an hash of germqtt_config resources. Example:
#   { 'DEFAULT/foo' => { value => 'fooValue'},
#     'DEFAULT/bar' => { value => 'barValue'}
#   }
#   In yaml format, Example:
#   germqtt_config:
#     DEFAULT/foo:
#       value: fooValue
#     DEFAULT/bar:
#       value: barValue
#
#   NOTE: The configuration MUST NOT be already handled by this module
#   or Puppet catalog compilation will fail with duplicate resources.
#
class germqtt::config (
  $germqtt_config = {},
) {

  validate_hash($germqtt_config)

  create_resources('germqtt_config', $germqtt_config)
}
