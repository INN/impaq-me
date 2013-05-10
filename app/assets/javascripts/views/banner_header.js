window.app.views.BannerHeader = Backbone.View.extend({
  template: JST['banner_header'],

  events: {
    // "click button": "close",
    // click: "openWidget" //TODO handle repeat clicks
  },

  initialize: function(options){
    _.bindAll(this);
    // window.setTimeout(this.minimize, 10000);
  },

  // close: function(){
  //   this.$el.slideUp().promise().then(this.remove);
  // },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});
