define modprobe::kern_module(
  $ensure = 'present'
){
  file_line{"module_${name}":
    line => $::operatingsystem ? {
      debian => $name,
      ubuntu => $name,
      default => "/sbin/modprobe $name"
    },
    path => $::operatingsystem ? {
      debian => '/etc/modules',
      ubuntu => '/etc/modules',
      default => '/etc/rc.modules'
    },
    ensure => $ensure,
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
