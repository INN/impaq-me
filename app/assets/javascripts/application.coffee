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
