#!/bin/bash -e

heroku pgbackups:capture -a impaqme

curl -o latest.dump `heroku pgbackups:url -a impaqme`

rake db:create:all

pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $USER -d impaqme_development latest.dump

rm latest.dump
