# Class: java
#
# This module manages Java, both versions and implementations
# Parameters: none
# Requires:
#  apt
# Sample Usage:
#  include java
#
class java(
  $java_version = 8,
  $oracle_java = true
) {

  # Initial parameter check

  if ! is_integer($java_version) {
    fail("\"${java_version}\" is not a valid integer parameter value")
  }

  # Initial variables
  $supported_oracle_versions  = [6, 7, 8]
  $supported_openjdk_versions = [6, 7]


  # Installation

  if $oracle_java == true {
    # Check if a supported Java version is selected
    if $java_version in $supported_oracle_versions {
      notice( "Installing Java version ${java_version}" )
      $java_ver = "oracle-java${java_version}-installer"
      if $::operatingsystem == 'debian' {
        apt::source { 'webupd8team':
          location     => 'http://ppa.launchpad.net/webupd8team/java/ubuntu',
          release      => 'precise',
          repos        => 'main',
          key          => 'EEA14886',
          key_server   => 'keyserver.ubuntu.com',
          include_src  => true
        }
        $todo = [
          Exec['apt-get update'],
          File['/tmp/java.preseed']
        ]
      }
    }
  }
  else
  {
    # OpenJDK
    if $java_version in $supported_openjdk_versions {
      notice( "Installing Java version ${java_version}" )
      $java_ver = "openjdk-${java_version}-jdk"
      apt::ppa { 'ppa:webupd8team/java': }
      $todo = [
        Exec['apt-get update'],
        File['/tmp/java.preseed']
      ]
    }
    else
    {
      notice("Failed to install OpenJDK Java \"${java_version}\"...")
      notice('Supported versions: 6,7')
      fail("Reason: \"${java_version}\" is not a supported version.")
    }
  }

  case $::operatingsystem {
    debian: {
      include apt

      package { $java_ver:
        responsefile => '/tmp/java.preseed',
        require      => $todo
      }
    }
    ubuntu: {
      include apt

      package { $java_ver:
        responsefile => '/tmp/java.preseed',
        require      => $todo
      }
    }
    default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }

  case $::operatingsystem {
    debian, ubuntu: {
      file { '/tmp/java.preseed':
        source => 'puppet:///modules/java/java.preseed',
        mode   => '0600',
        backup => false,
      }
    }
    default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }
}

