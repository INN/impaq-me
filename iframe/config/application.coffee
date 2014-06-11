# Exports a function which returns an object that overrides the default &
#    plugin grunt configuration object.
#
#  You can familiarize yourself with Lineman's defaults by checking out:
#
#    - https://github.com/linemanjs/lineman/blob/master/config/application.coffee
#    - https://github.com/linemanjs/lineman/blob/master/config/plugins
#
#  You can also ask Lineman's about config from the command line:
#
#    $ lineman config #=> to print the entire config
#    $ lineman config concat_sourcemap.js #=> to see the JS config for the concat task.
#
module.exports = (lineman) ->
  app = lineman.config.application

  prependTasks:
    common: addFetchIfBuilding(app)

  plugins:
    rails:
      namespace: "iframe"



addFetchIfBuilding = (app) ->
  return app.prependTasks.common unless process.env["LINEMAN_ENV"] == "production"
  app.prependTasks.common.concat("fetch:facebook-connect-api-all:google-analytics:twitter-widgets-api")
