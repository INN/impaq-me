# Exports a function which returns an object that overrides the default &
#    plugin file patterns (used widely through the app configuration)
#
#  To see the default definitions for Lineman's file paths and globs, see:
#
#    - https://github.com/linemanjs/lineman/blob/master/config/files.coffee
#
module.exports = (lineman) ->
  coffee:
    app: [
      "app/js/app.coffee"
      "app/js/template.coffee"
      "app/js/models/**/*.coffee"
      "app/js/helpers/**/*.coffee"
      "app/js/views/**/*.coffee"
      "app/js/services/**/*.coffee"
      "app/js/ext/**/*.coffee"
      "app/js/router.coffee"
      "app/js/social_network_events.coffee"
      "app/js/**/*.coffee"
    ]
  js:
    vendor: [
      "vendor/js/jquery.js"
      "vendor/js/underscore.js"
      "vendor/js/backbone.js"
      "vendor/js/**/*.js"
    ]
