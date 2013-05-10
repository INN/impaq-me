window.app.Router = Backbone.Router.extend({
  initialize: function(options){
    window.app.views.window = new app.views.Window();
  },

  routes: {
    "" : "widget_closed",

    "widget/closed" : "widget_closed",
    "widget/open" : "widget_open",

    "banner" : "banner_maximized",
    "banner/maximized" : "banner_maximized",
    "banner/minimized" : "banner_minimized",

    "all" : "all"
  },

  widget_open: function(){
    app.views.widget.render().open();
  },

  widget_closed: function(){
    app.views.widget.render().close();
  },

  banner_maximized: function(){
    app.views.banner.render().maximize();
  },

  banner_minimized: function(){
    app.views.banner.render().minimize();
  },

  // all: function(){
  //   $("#banner").empty()
  //     .append(app.views.banner_info.el)
  //     .append(app.views.banner_header.el);
  //   $("#widget").empty()
  //     .append(app.views.widget_header.el)
  //     .append(app.views.share.el)
  //     .append(app.views.widget_body.el);
  // }

});


jQuery(function($){
  window.app.router = new window.app.Router();

  _.extend(window.app.views, {
    banner: new app.views.Banner({el: $("#banner")}),
    widget: new app.views.Widget({el: $("#widget")})
  });

  Backbone.history.start();
});
