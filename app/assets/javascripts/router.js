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
    $('main').empty().append(app.views.widget.render().el);
    app.models.widget.set({
      mode: 'widget',
      open: true
    });
  },

  widget_closed: function(){
    $('main').empty().append(app.views.widget.render().el);
    app.models.widget.set({
      mode: 'widget',
      open: false
    });
  },

  banner_maximized: function(){
    $('main').empty()
      .append(app.views.banner.render().el)
      .append(app.views.widget.render().el);
    app.views.banner.maximize();
    app.models.widget.set({
      mode: 'banner',
      open: false
    });
  },

  banner_minimized: function(){
    $('main').empty()
      .append(app.views.banner.render().el)
      .append(app.views.widget.render().el);
    app.views.banner.minimize();
    app.models.widget.set({
      mode: 'banner',
      open: false
    });
  }
});


jQuery(function($){
  window.app.router = new window.app.Router();

  app.models.widget = new app.models.Widget(impaqme);
  _.extend(window.app.views, {
    banner: new app.views.Banner({ model: app.models.widget }),
    widget: new app.views.Widget({ model: app.models.widget })
  });

  Backbone.history.start();
});
