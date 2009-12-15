class modprobe::modulesfile {
    file{'/etc/rc.modules':
        ensure => file,
        owner => root, group => 0, mode => 755;
    }
}
