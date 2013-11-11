# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file. (EDIT: added require_self, so this file is inserted *after* vendor, but before everything else)
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require vendor
#= require_self
#= require template
#= require_tree ../templates
#= require_tree ./models
#= require_tree ./helpers
#= require_tree ./views
#= require_tree ./services
#= require_tree .

# set up namespaces
window.app =
  models: {}
  helpers: {}
  views: {}
  services: {}
  events: _({}).extend(Backbone.Events)
