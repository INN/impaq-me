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

_ = require('underscore')
module.exports = (lineman) ->
  app = lineman.config.application

  plugins:
    lib:
      includeVendorInDistribution: true
      generateBowerJson: false

  removeTasks:
    common: _(app.removeTasks.common).without("pages:dev")
    dev: _(app.removeTasks.dev).without("server")

  watch:
    pages:
      files: "<%= files.pages.source %>"
      tasks: ["pages:dev"]
