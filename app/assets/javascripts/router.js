window.app.Router = Backbone.Router.extend({
  routes: {
    "" : "home"
  },

  home: function() {
    $("main")
      .append(new window.app.views.Share().render().el)
      .append(new window.app.views.Meter().render().el)
      .append(new window.app.views.Solicit().render().el)
      .append(new window.app.views.Donate().render().el)
  }

});
