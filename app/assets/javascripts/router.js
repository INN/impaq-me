window.app.Router = Backbone.Router.extend({
  initialize: function(){
    _.bindAll(this);

    // not using Backbone's real routing
    // Backbone's fragment-based routing causing the host page to scroll:
    // test case: http://jsfiddle.net/dTQEE/1/
    this.routes = {
      "widget"        : this.widget_closed,
      "widget/closed" : this.widget_closed,
      "widget/open"   : this.widget_open,

      "banner"           : this.banner_maximized,
      "banner/maximized" : this.banner_maximized,
      "banner/minimized" : this.banner_minimized
    };
  },

  start: function(){
    var query = new URI().query(true);
    this.routes[query.mode]();
  },

  widget_open: function(){
    app.services.Analytics.trackPageview("/widget/open");
    $('main').empty().append(app.views.widget.render().el);
    app.models.widget.set({
      mode: 'widget',
      open: true
    });
  },

  widget_closed: function(){
    app.services.Analytics.trackPageview("/widget/closed");
    $('main').empty().append(app.views.widget.render().el);
    app.models.widget.set({
      mode: 'widget',
      open: false
    });
  },

  banner_maximized: function(){
    app.services.Analytics.trackPageview("/banner/maximized");
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
    app.services.Analytics.trackPageview("/banner/minimized");
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
  window.app.models.widget = new app.models.Widget(impaqme);
  window.app.models.social = new app.models.Social(impaqme);// TODO trim down the bootstrap object

  _(window.app.views).extend({
    window: new app.views.Window({ model: app.models.widget }),
    banner: new app.views.Banner({ model: app.models.widget }),
    widget: new app.views.Widget({ model: app.models.widget })
  });

  app.router.start();
});
