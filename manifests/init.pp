# == Class: jmeter
#
# This class installs the latest stable version of JMeter.
#
# === Examples
#
#   class { 'jmeter': }
#
class jmeter (
  $install_path    = $::jmeter::params::install_path,
  $bin_path        = $::jmeter::params::bin_path,
  $version         = $::jmeter::params::version,
  $plugins_install = $::jmeter::params::plugins_install,
  $plugins_version = $::jmeter::params::plugins_version,
  $plugins_set     = $::jmeter::params::plugins_set,
) inherits jmeter::params {

  Exec { path => '/bin:/usr/bin:/usr/sbin' }

  $packages = [ 'unzip', 'wget' ]
  package { $packages: ensure => present }

  exec { 'download-jmeter':
    command => "wget -P /tmp http://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${version}.tgz",
    creates => "/tmp/apache-jmeter-${version}.tgz"
  }

  exec { 'install-jmeter':
    command => "tar xzf /tmp/apache-jmeter-${version}.tgz && mv apache-jmeter-${version} jmeter",
    cwd     => $install_path,
    creates => "$install_path/jmeter",
    require => Exec['download-jmeter'],
  }

  file { "$bin_path/jmeter":
    ensure => link
    require => Exec['install-jmeter']
  }

  if $plugins_install == true {
    jmeter::plugins_install { $plugins_set:
      install_path    => $install_path,
      plugins_version => $plugins_version,
      require         => [Package['wget'], Package['unzip'], Exec['install-jmeter']],
    }
  }
}
