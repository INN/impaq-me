###
  Exports an object that defines all of the configuration needed by the projects' depended-on grunt tasks.
  You can find the parent object in: node_modules/lineman/config/application.coffee
###

module.exports = require('lineman').config.extend('application',

  appTasks:
    common: ["coffee", "less", "jshint", "handlebars", "jst", "configure", "concat", "images:dev", "webfonts:dev", "homepage:dev"]
    dist: ["uglify", "cssmin", "images:dist", "webfonts:dist", "homepage:dist"]

  coffee:
    widget:
      files: "<%= files.glob.coffee.widget_generated %>": "<%= files.coffee.widget %>"

  jshint:
    widget:
      files: ["<%= files.js.widget %>"]

  concat:
    widget:
      src: ["<%= files.coffee.widget_generated %>", "<%= files.js.widget %>"]
      dest: "<%= files.glob.js.widget_concatenated %>"

  uglify:
    widget:
      files: "<%= files.glob.js.widget_minified %>": "<%= files.glob.js.widget_concatenated %>"

  clean:
    widget:
      src: "<%= files.js.widget_concatenated %>"

  watch:
    widget_js:
      files: "<%= files.glob.js.widget %>"
      tasks: ["configure", "concat:widget"]

    widget_coffee:
      files: "<%= files.glob.coffee.widget %>"
      tasks: ["configure","coffee:widget","configure","concat:widget"]

    widget_lint:
      files: "<%= files.glob.js.widget %>"
      tasks: ["configure","jshint:widget"]

  homepage:
    template: "app/templates/index.us"
    dev:
      dest: "generated/index.html"
      context:
        js: "js/app.js"
        css: "css/app.css"
    dist:
      dest: "dist/index.html"
      context:
        js: "js/app.min.js"
        css: "css/app.min.css"

)
