#
# modprobe module
#
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

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
