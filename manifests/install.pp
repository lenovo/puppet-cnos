# Private class
class cnos::install {
  if $::puppetversion and $::puppetversion =~ /Puppet Enterprise/ {
    $provider = 'pe_gem'
  } elsif $::puppetversion and versioncmp($::puppetversion, '4.0.0') >= 0 {
    $provider = 'puppet_gem'
  } else {
    $provider = 'gem'
  }
  package { 'lenovo-rbapi':
    ensure   => '0.0.5',
    provider => $provider,
  }
  package { 'rest-client' :
    ensure   => '2.0.2',
    provider => 'puppet_gem',
  }
}
