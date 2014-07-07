# == Class: aws
#
# Installs the AWS Command Line Interface
# See: http://aws.amazon.com/cli
#
# === Examples
#
#  class { "aws":}
#
# === Authors
#
# Alex Kalyvitis <alex.kalyvitis@yieldr.com>
#
class aws (
  $region            = '',
  $access_key_id     = '',
  $secret_access_key = '',
  $config_dir        = '/root/.aws',
  $config_file       = 'conf',
) {

  class { 'python':
    pip => true,
  }

  python::pip { 'awscli':
    pkgname => 'awscli',
  }

  file { $config_dir:
    ensure => directory,
    recurse => true,
  }

  file { "$config_dir/$config_file":
    content => template("aws/aws.conf.erb"),
    owner   => root,
    group   => root,
    mode    => "a+r",
  }
}
