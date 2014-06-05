# Exports a function which returns an object that overrides the default &
#    plugin file patterns (used widely through the app configuration)
#
#  To see the default definitions for Lineman's file paths and globs, see:
#
#    - https://github.com/linemanjs/lineman/blob/master/config/files.coffee
#
module.exports = (lineman) ->
  js:
    minified: "dist/js/impaq-me-sdk.min.js",
    uncompressedDist: "dist/js/impaq-me-sdk.js"
