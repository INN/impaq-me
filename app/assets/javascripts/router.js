window.app.Router = Backbone.Router.extend({
  initialize: function(options){
    window.app.views.window = new app.views.Window();
  },

  routes: {
    "" : "home",
    "shared" : "shared"
  },

  home: function() {
    $("main > div > div").empty()
      .append(app.views.share.el)
      .append(app.views.meter.el);
    $("main")
      .append(app.views.solicit.el)
      .append(app.views.donate.el);
  },

  shared: function() {
    var solicit = app.views.solicit.$el;
    var thanks = app.views.thanks.$el;
    var feedback = app.views.feedback.$el;
    var donate = app.views.donate.$el;

    thanks.css({opacity:0}).hide().insertAfter(solicit);
    feedback.css({opacity:0}).hide().insertBefore(donate);

    $.when(
      solicit.animate({opacity:0}, 'slow'),
      feedback.slideDown('slow')
    ).done(function(){
      solicit.remove(); //TODO fix the potential remove/show jitter
      thanks.show().animate({opacity:1}, 'slow');
      feedback.show().animate({opacity:1}, 'slow');
    });
  }

});


jQuery(function($){
  _.extend(window.app.views, {
    share:    new app.views.Share().render(),
    meter:    new app.views.Meter().render(),
    solicit:  new app.views.Solicit().render(),
    thanks:   new app.views.Thanks().render(),
    feedback: new app.views.Feedback().render(),
    donate:   new app.views.Donate().render()
  });

  window.app.router = new window.app.Router();
  Backbone.history.start();

});
