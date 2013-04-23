/* Exports an object that defines
 *  all of the paths & globs that the project
 *  is concerned with.
 *
 * The "configure" task will require this file and
 *  then re-initialize the grunt config such that
 *  directives like <config:files.js.app> will work
 *  regardless of the point you're at in the build
 *  lifecycle.
 *
 * You can find the parent object in: node_modules/lineman/config/files.coffee
 */

module.exports = require('lineman').config.extend('files', {

  coffee: {
    widget: "widget/js/**/*.coffee",
    widget_generated: "generated/js/widget.coffee.js"
  },

  js: {
    widget: "widget/js/**/*.js",
    widget_concatenated: "generated/js/widget.js",
    widget_minified: "dist/js/widget.min.js"
  }

});
