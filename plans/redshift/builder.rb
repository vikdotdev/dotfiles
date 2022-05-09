ensure_write_file(home_file('.config/redshift/redshift.conf'),
                  read_file('redshift.conf'))

ensure_write_file(home_file('.config/systemd/user/redshift.service'),
                  read_file('redshift.service'))
ensure_service_running('redshift.service')
