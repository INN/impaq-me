module.exports = require('lineman').config.extend 'application',

  loadNpmTasks: [ 'grunt-contrib-copy' ]
  # appTasks:
  #   common: [ 'coffee', 'jshint', 'concat:dev' ]
  #   dev: [ 'watch' ]
  #   dist: [ 'concat:dist', 'uglify:dist' ]

  removeTasks:
    common: ["less", "handlebars", "jst", "concat", "images:dev", "webfonts:dev", "pages:dev"]
    dev: ["server"]
    dist: ["cssmin", "images:dist", "webfonts:dist", "pages:dist"]

  prependTasks:
    dev: [ "concat:dev", "copy:dev" ]

  appendTasks:
    dist: [ "concat:dist", "copy:dist" ]

  meta:
    banner: """
            """

  concat:
    dev:
      options: process: data: iframe_host: "//localhost:3000"
      src: "<%= concat.js.src %>"
      dest: "<%= files.js.concatenated %>"
    dist:
      options: process: data: iframe_host: "//www.impaq.me"
      src: "<%= concat.js.src %>"
      dest: "<%= files.js.concatenated %>"

  uglify:
    js:
      src: "<%= files.js.concatenated %>"
      dest: "<%= files.js.minified %>"

  copy:
    dev:
      src: "<%= files.js.concatenated %>"
      dest: "<%= files.js.dist %>"
    dist:
      src: "<%= files.js.minified %>"
      dest: "<%= files.js.dist %>"

  watch:
    js:
      files: [ "<%= files.js.vendor %>", "<%= files.js.app %>" ]
      tasks: [ "concat:dev", "copy:dev" ]

    coffee:
      files: "<%= files.coffee.app %>"
      tasks: [ "coffee", "concat:dev", "copy:dev" ]
