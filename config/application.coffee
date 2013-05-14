###
  Exports an object that defines
  all of the configuration needed by the projects'
  depended-on grunt tasks.

  You can find the parent object in: node_modules/lineman/config/application.coffee
###

# console.log(require('lineman').config.extend('application', {appTasks: null}));
config = require('lineman').config.extend('application',
  server:
    web:
      port: 8002
)
config.appTasks.common.pop()
config.appTasks.dist.pop()
module.exports = config
