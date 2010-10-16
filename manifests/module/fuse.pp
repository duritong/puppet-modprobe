class modprobe::module::fuse {
  package{'fuse-utils':
    ensure => present,
  }
  modprobe::kern_module{'fuse':
    ensure => present,
  }
}
