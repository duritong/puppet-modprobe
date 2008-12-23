# manifests/loadfile.pp

class modprobe::loadfile {
    case $operatingsystem {
        redhat,centos,fedora: { 
            file{'/etc/rc.modules': 
                ensure => file, 
                mode => 755 
            } 
        }
    }
}
