# == Class: jmeter::params
#
class jmeter::params {
  if $::osfamily == 'RedHat' {
    $install_path    = '/opt/jmeter'
    $bin_path        = '/usr/local/bin'
    $version         = '2.13'
    $plugins_install = false
    $plugins_version = '1.2.1'
    $plugins_set     = ['Standard']
  } else {
    fail("Class['jmeter::params']: Unsupported osfamily: ${::osfamily}")
  }
}
