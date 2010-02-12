define modprobe::kern_module(
    $ensure = 'present'
){
    case $operatingsystem {
        debian,ubuntu: {
            $modulesfile = '/etc/modules'
        }
        default: {
            $modulesfile = '/etc/rc.modules'
        }
    }
    case $ensure {
        present: {
            exec{"insert_module_$name":
                command => "/bin/echo '/sbin/modprobe $name' >> $modulesfile",
                unless => "/bin/grep -qFx '/sbin/modprobe $name' $modulesfile",
            }
            exec{"/sbin/modprobe $name":
                unless => "/bin/grep -q '^$name ' /proc/modules" 
            }
            case $operatingsystem {
                debian,ubuntu: {
                    Exec["insert_module_$name"]{
                        command => "/bin/echo '$name' >> $modulesfile",
                        unless => "/bin/grep -qFx '$name' $modulesfile",
                    }
                }
            }
        }
        absent: {
            exec{"/sbin/modprobe -r $name":
                onlyif => "/bin/grep -q '^$name ' /proc/modules"
            }
            exec{"remove_module_$name":
                command => "/bin/sed -i '/^\\/sbin\\/modprobe $name$/d' $modulesfile",
                onlyif => "/bin/grep -qFx '/sbin/modprobe $name' $modulesfile",
            }
            case $operatingsystem {
                debian,ubuntu: {
                    Exec["remove_module_$name"]{
                        command => "/bin/sed -i '/^$name$/d' $modulesfile",
                        onlyif => "/bin/grep -qFx '$name' $modulesfile",
                    }
                }
            }
        }
        default: {
            fail("Unknown ensure value '$ensure' for modprobe::kern_module!")
        }
    }
}
