/* Exports an object that defines
 *  all of the configuration needed by the projects'
 *  depended-on grunt tasks.
 *
 * You can find the parent object in: node_modules/lineman/config/application.coffee
 */

module.exports = require('lineman').config.extend('application', {

  appTasks: {
    common: ["coffee", "less", "jshint", "handlebars", "jst", "configure", "concat", "images:dev", "webfonts:dev", "homepage:dev"],
    dist: ["uglify", "cssmin", "images:dist", "webfonts:dist", "homepage:dist"]
  },

  coffee: {
    widget: {
      files: {
        "<%= files.glob.coffee.widget_generated %>": "<%= files.coffee.widget %>"
      }
    }
  },

  jshint: {
    widget: {
      files: ["<%= files.js.widget %>"]
    }
  },

  concat: {
    widget: {
      src: ["<%= files.coffee.widget_generated %>", "<%= files.js.widget %>"],
      dest: "<%= files.glob.js.widget_concatenated %>"
    }
  },

  uglify: {
    widget: {
      files: {
        "<%= files.glob.js.widget_minified %>": "<%= files.glob.js.widget_concatenated %>"
      }
    }
  },

  clean: {
    widget: {
      src: "<%= files.js.widget_concatenated %>"
    }
  }

});
