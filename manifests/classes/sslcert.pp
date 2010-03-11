class monitoring::sslcert {

  $rev  = "1144" # svn revision number, increment after testing.
  $repo = "https://trac.id.ethz.ch/projects/nagios_plugins"
  $url  = "${repo}/export/${rev}/check_ssl_cert/check_ssl_cert"

  exec { "download check_ssl_cert":
    command => "curl -o /opt/nagios-plugins/check_ssl_cert-r${rev} ${url}",
    creates => "/opt/nagios-plugins/check_ssl_cert-r${rev}",
    require => [File["/opt/nagios-plugins/"], Package["curl"]],
  }

  file { "/opt/nagios-plugins/check_ssl_cert-r${rev}":
    owner   => "root",
    mode    => 0755,
    require => Exec["download check_ssl_cert"],
  }

  file { "/opt/nagios-plugins/check_ssl_cert":
    ensure  => link,
    target  => "/opt/nagios-plugins/check_ssl_cert-r${rev}",
    require => File["/opt/nagios-plugins/check_ssl_cert-r${rev}"],
  }

}

/*

== Definition: monitoring::check::sslcert

A small wrapper around monitoring::check-

Not included in monitoring::sslcert because we could need to check more than
one certificate per host.

*/
define monitoring::check::sslcert (
  $ensure="present",
  $host="localhost", # check local certificate by default
  $org=$sslcert_organisation, # see apache::base::ssl
  $port="443",
  $days="45") {

  $rootcrt = $operatingsystem ? {
    Debian => "/etc/ssl/certs/ca-certificates.crt",
    RedHat => "/etc/pki/tls/certs/ca-bundle.crt",
  }

  monitoring::check { "SSL Cert: $name:$port":
    codename => "check_ssl_cert_${name}_${port}",
    command  => "check_ssl_cert",
    interval => "720", # 2x/day
    base     => '$USER2$/',
    options  => "-H ${host} -n ${name} -p ${port} -r ${rootcrt} -d ${days} -o '${org}'",
  }

}

