#!/bin/bash
cat <<EOF >/tmp/__$$__bin.ctl
LOAD DATA INFILE * APPEND INTO TABLE BLOB_BIN_T fields terminated by '"-,-"'
( paste_date char, command char, BINDATA LOBFILE(CONSTANT '') terminated by eof )
BEGINDATA
$(date +%Y-%m-%d_%H:%M:%S.%N)"-,-"$*"-,-"
EOF
export NLS_TIMESTAMP_FORMAT="YYYY-MM-DD_HH24:MI:SSXFF9"
sqlldr soe/soe@localhost/pdb1.gse00002893.oraclecloud.internal sdf_prefix=<($*) control=/tmp/__$$__bin.ctl < <($*)
