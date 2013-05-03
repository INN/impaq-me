window.app.Router = Backbone.Router.extend({
  routes: {
    "" : "home"
  },

  home: function() {
    $(".padded").append(new window.app.views.Share().render().el);
  }

});


