window.app.views.Banner = Backbone.View.extend({
  template: JST['banner'],

  events: {
    "click button": "close"
  },

  initialize: function(options){
    _.bindAll(this);
  },

  close: function(){
    console.log("nuclear");
  },

  minimize: function(){
    console.log("minimize");
    this.$('.thanks').slideUp();
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});
