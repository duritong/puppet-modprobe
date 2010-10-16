class modprobe::module::fuse {
  modprobe::kern_module{'fuse':
    ensure => present,
  }
}
