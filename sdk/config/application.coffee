module.exports = require('lineman').config.extend 'application',

  loadNpmTasks: [ 'grunt-contrib-copy' ]

  appTasks:
    common: [ 'coffee', 'jshint' ]
    dev: [ 'concat:dev', 'copy:dev', 'watch' ]
    dist: [ 'concat:dist', 'uglify', 'copy:dist' ]

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
