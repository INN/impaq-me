window.app.views.BannerHeader = Backbone.View.extend({
  template: JST['banner_header'],

  events: {
    "click button": "close"
  },

  initialize: function(options){
    _.bindAll(this);
  },

  close: function(){
    this.$el.slideUp().promise().then(this.remove);
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});
