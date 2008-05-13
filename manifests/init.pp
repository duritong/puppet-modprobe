#######################################
# modprobe module
# Puzzle ITC - haerry+puppet(at)puzzle.ch
# GPLv3
#######################################


# modules_dir { "modprobe": }
class modprobe {

    file{"/etc/modprobe.conf":
        source => [ "puppet://$server/files/modprobe/${fqdn}/modprobe.conf",
                    "puppet://$server/files/modprobe/${virtual}/modprobe.conf",
                    "puppet://$server/files/modprobe/${operatingsystem}/modprobe.conf",
                    "puppet://$server/files/modprobe/modprobe.conf",
                    "puppet://$server/modprobe/${virtual}/modprobe.conf",
                    "puppet://$server/modprobe/${operatingsystem}/modprobe.conf",
                    "puppet://$server/modprobe/modprobe.conf" ],
        owner => root, group => 0, mode => 0644;
    }

}
