$gerrit_public_key = 'ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFnYsbHrGl99in5doo1uy+V3N3ayR4J0/sJprK+7E8exDwAGe1vZmUftjZ6uMi4RckxuFTuVJdxrFvTLEQpNrSU='

$gerrit_private_key = 'MHcCAQEEIJUIOR4hPwqds8ESewPHm+r5ejSqjuFjBfVa7jQTH99QoAoGCCqGSM49
AwEHoUQDQgAEWdixsesaX32Kfl2ijW7L5Xc3drJHgnT+wmmsr7sTx7EPAAZ7W9mZ
R+2Nnq4yLhFyTG4VO5Ul3GsW9MsRCk2tJQ==
-----END EC PRIVATE KEY-----'

$gerrit_ssh_host_key = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfsIj/jqpI+2CFdjCL6kOiqdORWvxQ2sQbCzSzzmLXic8yVhCCbwarkvEpfUOHG4eyB0vqVZfMffxf0Yy3qjURrsroBCiuJ8GdiAcGdfYwHNfBI0cR6kydBZL537YDasIk0Z3ILzhwf7474LmkVzS7V2tMTb4ZiBS/jUeiHsVp88FZhIBkyhlb/awAGcUxT5U4QBXCAmerYXeB47FPuz9JFOVyF08LzH9JRe9tfXtqaCNhlSdRe/2pPRvn2EIhn5uHWwATACG9MBdrK8xv8LqPOik2w1JkgLWyBj11vDd5I3IjrmREGw8dqImqp0r6MD8rxqADlc1elfDIXYsy+TVH'

include germqtt
class {'germqtt::server':
  gerrit_username     => 'gerrit_username',
  gerrit_public_key   => $gerrit_public_key,
  gerrit_private_key  => $gerrit_private_key,
  gerrit_ssh_host_key => $gerrit_ssh_host_key,
  mqtt_username       => 'mqtt_username',
  mqtt_password       => 'mqtt_password',
}
