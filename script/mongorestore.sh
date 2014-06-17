#!/bin/bash -e

mongodump -h zach.mongohq.com:10015 -d app15233185 -u heroku -p 22daece1d5c89bf50cf7ac6f172a35f7 -o db/dump/app15233185.mongo
mongorestore --drop db/dump/app15233185.mongo
