class modprobe::modulesfile {
    case $operatingsystem {
        debian,ubuntu: {
            file{'/etc/modules':
                ensure => file,
                owner => root, group => 0, mode => 755;
            }
        }
        default: {
            file{'/etc/rc.modules':
                ensure => file,
                owner => root, group => 0, mode => 755;
            }
        }
    }
}
