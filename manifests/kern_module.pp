define modprobe::kern_module(
  $ensure = 'present'
){
  if ($osfamily != 'RedHat') or versioncmp($operatingsystemmajrelease,'7') < 0 {
    $line = $::operatingsystem ? {
      /(Debian|Ubuntu)/  => $name,
      default => "/sbin/modprobe $name"
    }
    $path = $::operatingsystem ? {
      /(Debian|Ubuntu)/ => '/etc/modules',
      ubuntu            => '/etc/modules',
      default           => '/etc/rc.modules'
    }
    file_line{"module_${name}":
      line   => $line,
      path   => $path,
      ensure => $ensure,
    }
  } else {
    file{"/etc/modules-load.d/${name}.conf":
      content => "# managed by puppet\n${name}\n",
      owner   => root,
      group   => 0,
      mode    => '0644',
    }
  }
  case $ensure {
    present: {
      exec{"/sbin/modprobe ${name}":
        unless => "/bin/grep -q '^${name} ' /proc/modules" 
      }
    }
    absent: {
      exec{"/sbin/modprobe -r ${name}":
        onlyif => "/bin/grep -q '^${name} ' /proc/modules"
      }
    }
    default: {
      fail("Unknown ensure value '$ensure' for modprobe::kern_module!")
    }
  }
}
