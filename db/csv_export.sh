#! /bin/sh -x

# execute as
# db/csv_export.sh shares
# or
# db/csv_export.sh click_throughs

heroku config:get MONGOHQ_URL | awk 'BEGIN { FS = ":|@|/" }; { print "--host",$6,"--port",$7,"--db",$8,"--username",$4,"--password",$5 }' | xargs -p mongoexport --csv --collection $1 --fieldFile db/$1_field_file.txt --out db/dump/$1-$(date -ju +%Y-%m-%dT%H:%M:%SZ).csv
