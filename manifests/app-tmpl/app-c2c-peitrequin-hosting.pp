class app-c2c-peitrequin-hosting {
  c2c::ssh_authorized_key {
    "ebelo on admin":    user => "admin", sadb_user => "ebelo";
    "ochriste on admin": user => "admin", sadb_user => "ochriste";
    "fredj on admin":    user => "admin", sadb_user => "fredj";
    "yves on admin":     user => "admin", sadb_user => "yves";
    "alex on admin":     user => "admin", sadb_user => "alex";
    "yjacolin on admin": user => "admin", sadb_user => "yjacolin";
    "aabt on admin":     user => "admin", sadb_user => "aabt";
  }

  apache::vhost {[
    "coppet.geocommunes.ch",
    "arzier.geocommunes.ch",
    "crans.geocommunes.ch",
    "trelex.geocommunes.ch",
    "genolier.geocommunes.ch",
    "common.geocommunes.ch",
    ]:
    ensure => present,
    mode   => 2775,
    group  => "sigdev",
  }

  group {"sigdev":
    ensure => present,
  }

  tomcat::instance {"printing":
    ensure => present,
    group  => sigdev,
  }

  apt::sources_list {"mapserver-5.6":
    ensure => present,
    content => "deb http://pkg.camptocamp.net/stable lenny mapserver-5.6\n"
  }

  apt::preferences {
    "libgdal1-1.7.0":   priority => 1100, pin => "release o=Camptocamp";
    "mapserver-bin":    priority => 1100, pin => "release o=Camptocamp";
    "cgi-mapserver":    priority => 1100, pin => "release o=Camptocamp";
    "perl-mapscript":   priority => 1100, pin => "release o=Camptocamp";
    "php5-mapscript":   priority => 1100, pin => "release o=Camptocamp";
    "python-mapscript": priority => 1100, pin => "release o=Camptocamp";
  }

}