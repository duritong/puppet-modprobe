class modprobe::module::fuse {
  if $osfamily == 'RedHat' {
    $pkg_name = 'fuse'
  } else {
    $pkg_name = 'fuse-utils'
  }
  package{$pkg_name:
    ensure => present,
  } -> modprobe::kern_module{'fuse':
    ensure => present,
  }
}
