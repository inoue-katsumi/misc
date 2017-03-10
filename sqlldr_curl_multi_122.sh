#!/bin/bash
cat <<EOF > /tmp/_$$_sqlldr.ctl
LOAD DATA INFILE * TRUNCATE INTO TABLE WEB_FILES_T
fields terminated by '<end-of-record>'
( url  position(12) char(512),
  BINDATA LOBFILE(CONSTANT '') terminated by '<end-of-record>\n')
BEGINDATA
EOF
curl -fw "<field-sep>%{url_effective}<end-of-record>\n" --silent \
  $(echo $* | sed 's|https*://|_d_u_m_m_y_|g') |
    sed 's/_d_u_m_m_y_//' >> /tmp/_$$_sqlldr.ctl
sqlldr scott/tiger@//localhost/pdb1 \
  sdf_prefix=<( \
    curl -fw "<field-sep>%{url_effective}<end-of-record>\n" --silent $* |
      sed 's/<field-sep>[^<]*//g' ) \
  control=/tmp/_$$_sqlldr.ctl rows=1
