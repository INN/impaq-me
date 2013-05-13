window.app.Router = Backbone.Router.extend({
  initialize: function(options){
    window.app.views.window = new app.views.Window();
  },

  routes: {
    "" : "widget_closed",

    "widget" : "widget_closed",
    "widget/closed" : "widget_closed",
    "widget/open" : "widget_open",

    "banner" : "banner_maximized",
    "banner/maximized" : "banner_maximized",
    "banner/minimized" : "banner_minimized"

  },

  widget_open: function(){
    app.views.widget.render();
    app.models.widget.set({
      mode: 'widget',
      open: true
    });
  },

  widget_closed: function(){
    app.views.widget.render();
    app.models.widget.set({
      mode: 'widget',
      open: false
    });
  },

  banner_maximized: function(){
    app.views.banner.render().maximize();
  },

  banner_minimized: function(){
    app.views.banner.render().minimize();
  }
});


jQuery(function($){
  window.app.router = new window.app.Router();

  app.models.widget = new app.models.Widget(impaqme);
  _.extend(window.app.views, {
    banner: new app.views.Banner({
      el: $("#banner"),
      model: app.models.widget
    }),
    widget: new app.views.Widget({
      el: $("#widget"),
      model: app.models.widget
    })
  });

  Backbone.history.start();
});
