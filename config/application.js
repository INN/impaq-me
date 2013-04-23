/* Exports an object that defines
 *  all of the configuration needed by the projects'
 *  depended-on grunt tasks.
 *
 * You can find the parent object in: node_modules/lineman/config/application.coffee
 */

module.exports = require('lineman').config.extend('application', {

  coffee: {
    compile: {
      files: {
        "<%= files.glob.coffee.widget_generated %>": "<%= files.coffee.widget %>"
      }
    }
  },

  jshint: {
    files: ["<%= files.js.app %>", "<%= files.js.widget %>"]
  }

});
