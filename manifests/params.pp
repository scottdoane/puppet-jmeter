# == Class: jmeter::params
#
class jmeter::params {
  if $::osfamily == 'RedHat' {
    $install_path    = '/opt'
    $bin_path        = '/usr/local/bin'
    $version         = '2.13'
    $plugins_install = false
    $plugins_version = '1.2.1'
    $plugins_set     = ['Standard']

    $server_ip       = '0.0.0.0'
    $server_port     = undef
  } else {
    fail("Class['jmeter::params']: Unsupported osfamily: ${::osfamily}")
  }
}
