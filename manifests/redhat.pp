/*

= Class dovecot::redhat
Inherits dovecot::base, and set variables according to RedHat standards

Please do not include this class, it's better to "include dovecot".

*/

class dovecot::redhat inherits dovecot::base {

  Package['Dovecot'] {
    name => 'dovecot',
  }

}
