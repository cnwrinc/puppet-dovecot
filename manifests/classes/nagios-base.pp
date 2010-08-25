#
# modules/nagios/manifests/classes/base.pp
# manage distributed monitoring with nagios
# Copyright (C) 2008 Mathieu Bornoz <mathieu.bornoz@camptocamp.com>
# See LICENSE for the full license granted to you.
#

class nagios::base {

  include nagios::params

  case $operatingsystem {
    /Debian|Ubuntu/ : { $nagios_mail_path = '/usr/bin/mail' }
    /RedHat|CentOS|Fedora/ : { $nagios_mail_path = '/bin/mail' }
    default: { err ("operatingsystem $operatingsystem not yet implemented !") }
  }

  /* Common resources between base, redhat, and debian */

  service { "nagios":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package["nagios"],
  }

  exec { "nagios-restart":
    command     => undef,
    refreshonly => true,
  }

  exec { "nagios-reload":
    command     => undef,
    refreshonly => true,
  }

  file { "nagios read-write dir":
    ensure  => directory,
    owner   => "nagios",
    require => Package["nagios"],
  }

  file {"${nagios::params::rootdir}/resource.cfg":
    ensure  => present,
    mode    => 0644,
    owner   => root,
    group   => root,
  }

  nagios::resource { "USER1": value => "${nagios::params::user1}" }


  /* other common resources below */

  file { ["${nagios::params::rootdir}/auto-puppet", "${nagios::params::rootdir}/nagios.d"]:
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 755,
    require => Package["nagios"],
  }

  file { "${nagios::params::rootdir}/conf.d":
    ensure  => absent,
    force   => true,
    require => Package["nagios"],
  }

  # purge undefined nagios resources
  file { "${nagios::params::resourcedir}":
    ensure  => directory,
    source  => "puppet:///nagios/empty",
    owner   => root,
    group   => root,
    mode    => 644,
    purge   => true,
    force   => true,
    recurse => true,
    notify  => Exec["nagios-reload"],
  }

  file { "${nagios::params::conffile}":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    require => Package["nagios"],
  }

  file {"${nagios::params::resourcedir}/generic-host.cfg":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///nagios/generic-host.cfg",
    notify  => Exec["nagios-reload"],
  }

  file {"${nagios::params::resourcedir}/generic-command.cfg":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("nagios/generic-command.cfg.erb"),
    notify  => Exec["nagios-reload"],
  }

  file {"${nagios::params::resourcedir}/generic-timeperiod.cfg":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///nagios/generic-timeperiod.cfg",
    notify  => Exec["nagios-reload"],
  }

  file {"${nagios::params::resourcedir}/generic-service.cfg":
    ensure  => present,
  }

  file {"${nagios::params::resourcedir}/base-contacts.cfg":
    ensure => present,
  }

  nagios_contact { "root":
    contact_name                  => "root",
    alias                         => "Root",
    service_notification_period   => "24x7",
    host_notification_period      => "24x7",
    service_notification_options  => "w,u,c,r",
    host_notification_options     => "d,r",
    service_notification_commands => "notify-service-by-email",
    host_notification_commands    => "notify-host-by-email",
    email                         => "root",
    target                        => "${nagios::params::resourcedir}/base-contacts.cfg",
    notify                        => Exec["nagios-reload"],
  }

  nagios_contactgroup { "admins":
    contactgroup_name => "admins",
    alias             => "Nagios Administrators",
    members           => "root",
    target            => "${nagios::params::resourcedir}/base-contacts.cfg",
    notify            => Exec["nagios-reload"],
    require           => Nagios_Contact["root"],
  }
}
