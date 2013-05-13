/*

= Class dovecot::debian
Inherits dovecot::base, and set variables according to Debian standards

Please do not include this class, it's better to "include dovecot".

*/

class dovecot::debian inherits dovecot::base {

  Package['Dovecot'] {
    name => 'dovecot-common',
  }

  package {'Dovecot IMAP':
    ensure  => present,
    require => [ User['dovecot'], Group['dovecot'] ],
    name => 'dovecot-imapd',
  }

  package {'Dovecot POP3':
    ensure  => present,
    require => [ User['dovecot'], Group['dovecot'] ],
    name => 'dovecot-pop3d',
  }

  Service['dovecot'] {
    pattern => 'dovecot',
  }

}
