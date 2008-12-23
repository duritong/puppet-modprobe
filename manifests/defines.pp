# manifest/defines.pp
# taken from: http://reductivelabs.com/trac/puppet/wiki/Recipes/KernelModules

define modprobe::kern_module(
    $ensure = 'present'
){

    # chosse and load default file
    case $operatingsystem {
        debian: { $modulesfile = '/etc/modules' }
        default: { $modulesfile = '/etc/rc.modules' }
    }
    include modprobe::loadfile

    case $ensure {
        present: {
            exec{"insert_module_${name}":
                command => "/bin/echo '/sbin/modprobe ${name}' >> '${modulesfile}' ",
                unless => "/bin/grep -qFx '${name}' '${modulesfile}'"
            }
            case $operatingsystem {
                debian,ubuntu: {
                    Exec["insert_module_${name}"]{
                        command => "/bin/echo '${name}' >> '${modulesfile}'",
                    }
                }
            }
            exec{"/sbin/modprobe ${name}": 
                unless => "/bin/grep -q '^${name} ' '/proc/modules'" 
            }
        }
        absent: {
            exec{"/sbin/modprobe -r ${name}": 
                onlyif => "/bin/grep -q '^${name} ' '/proc/modules'" 
            }
            exec { "remove_module_${name}":
                command => "/usr/bin/perl -ni -e 'print unless /^\\Q/sbin/modprobe ${name}\\E\$/' '${modulesfile}'",
                onlyif => "/bin/grep -q '^/sbin/modprobe ${name}' '${modulesfile}'",
            }
            case $operatingsystem {
                debian,ubuntu: {
                    Exec["remove_module_${name}"]{
                        command => "/usr/bin/perl -ni -e 'print unless /^\\Q${name}\\E\$/' '${modulesfile}'",
                        onlyif => "/bin/grep -qFx '${name}' '${modulesfile}'",
                    }
                }
            }
        }
        default: { 
            fail("unknown ensure value ${ensure} to modprobe ${name} on ${fqdn}") 
        }
    }
}

