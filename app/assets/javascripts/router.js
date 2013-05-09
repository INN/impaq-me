window.app.Router = Backbone.Router.extend({
  initialize: function(options){
    window.app.views.window = new app.views.Window();
  },

  /*
   * Widget minimized
   * Widget open
   * Widget open -> after-share
   *
   * Banner minimized
   * Banner open
   * Banner open with widget
   * Banner open with widget after-share
   */

  routes: {
    "" : "home",
    "home" : "home",
    "banner" : "banner",
    "all" : "all"
  },

  home: function() {
    $("main").empty()
      .append(app.views.share.el)
      .append(app.views.solicit.el)
      .append(app.views.donate.el);
  },

  banner: function(){
    $("#banner").empty()
      .append(app.views.banner.el);
  },

  all: function(){
    $("#banner").empty()
      .append(app.views.banner.el);
    $("#widget").empty()
      .append(app.views.widget_header.el)
      .append(app.views.share.el)
      .append(app.views.solicit.el)
      .append(app.views.thanks.el)
      .append(app.views.donate.el)
      .append(app.views.footer.el);
  }

  // shared: function() {
  //   var solicit = app.views.solicit.$el;
  //   var thanks = app.views.thanks.$el;
  //   var feedback = app.views.feedback.$el;
  //   var donate = app.views.donate.$el;

  //   thanks.css({opacity:0}).hide().insertAfter(solicit);
  //   feedback.css({opacity:0}).hide().insertBefore(donate);

  //   $.when(
  //     solicit.animate({opacity:0}, 'slow'),
  //     feedback.slideDown('slow')
  //   ).done(function(){
  //     solicit.remove(); //TODO fix the potential remove/show jitter
  //     thanks.show().animate({opacity:1}, 'slow');
  //     feedback.show().animate({opacity:1}, 'slow');
  //   });
  // }

});


jQuery(function($){
  _.extend(window.app.views, {
    banner:    new app.views.Banner().render(),

    widget_header:  new app.views.WidgetHeader().render(),
    share:          new app.views.Share().render(),
    solicit:        new app.views.Solicit().render(),
    thanks:         new app.views.Thanks().render(),
    donate:         new app.views.Donate().render(),

    footer:         new app.views.Footer().render()
  });

  window.app.router = new window.app.Router();
  Backbone.history.start();

});
