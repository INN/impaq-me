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
        impaq_me_iframe: "http://localhost:8003/index.html"
    dist:
      context:
        impaq_me_iframe: "//impaq-me.herokuapp.com/index.html"
  server:
    web:
      port: 8002

)
