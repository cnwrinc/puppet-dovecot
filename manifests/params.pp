class dovecot::params (
  $dovecot_basedir                          = undef,
  $dovecot_protocols                        = undef,
  $dovecot_listen                           = undef,
  $dovecot_login_mode                       = undef,
  $dovecot_mail_location                    = undef,
  $dovecot_mail_gid                         = undef,
  $dovecot_mail_uid                         = undef,
  $dovecot_mail_privileged_group            = undef,
  $dovecot_imap_login_executable            = undef,
  $dovecot_imap_mail_executable             = undef,
  $dovecot_imap_mail_max_userip_connections = undef,
  $dovecot_imap_login_max_processes_count   = undef,
  $dovecot_imap_plugins                     = undef,
  $dovecot_pop3_login_executable            = undef,
  $dovecot_pop3_mail_executable             = undef,
  $dovecot_pop3_plugins                     = undef,
  $dovecot_lda_postmaster                   = undef,
  $dovecot_lda_hostname                     = undef,
  $dovecot_lda_plugins                      = undef,
  $dovecot_sieve_login_executable           = undef,
  $dovecot_sieve_mail_executable            = undef,
  $dovecot_sieve_plugins                    = undef,
  $dovecot_ssl_enabled                      = undef,
  $dovecot_ssl_listen                       = undef,
  $dovecot_ssl_cert                         = undef,
  $dovecot_ssl_key                          = undef,
  $dovecot_ssl_ca                           = undef,
  $dovecot_ssl_key_password                 = undef,
  $dovecot_ssl_cipher_list                  = undef,
  $dovecot_auth_ldap                        = false,
  $dovecot_auth_pam                         = false,
  $dovecot_auth_database                    = false,
  $slapd_domain                             = undef,
  $slapd_allow_v2                           = undef,
  $dovecot_ldap_uri                         = undef,
  $dovecot_ldap_bind_userdn                 = undef,
  $dovecot_ldap_userdb_prefetch             = undef,
  $dovecot_ldap_host                        = undef,
  $dovecot_ldap_base                        = undef,
  $dovecot_ldap_user_attrs                  = undef,
  $dovecot_ldap_pass_attrs                  = undef,
  $dovecot_ldap_user_filter                 = undef,
  $dovecot_ldap_pass_filter                 = undef,
  $dovecot_sql_host                         = undef,
  $dovecot_sql_dbname                       = undef,
  $dovecot_sql_user                         = undef,
  $dovecot_sql_password                     = undef,
  $dovecot_sql_user_query                   = undef,
  $dovecot_sql_password_query               = undef,
) {
  if !$dovecot_version {
    case $::operatingsystem {
      Debian: {
        case $::lsbdistcodename {
          default: { $version = 1}
        }
      }
      CentOS: {
        $version = 1
      }
      default: { $version = 1 }
    }
  } else {
    $version = $dovecot_version
  }
}
