###
  Exports an object that defines
  all of the configuration needed by the projects'
  depended-on grunt tasks.

  You can find the parent object in: node_modules/lineman/config/application.coffee
###

module.exports = require('lineman').config.extend('application',

  homepage:
    dev:
      context:
        impaq_me_iframe: "http://localhost:3000"
    dist:
      context:
        impaq_me_iframe: "//impaq-backend.herokuapp.com"
  server:
    web:
      port: 8002

)
