window.app.views.BannerHeader = Backbone.View.extend({
  template: JST['banner_header'],

  events: {
    "click button": "close",
    // click: "openWidget" //TODO handle repeat clicks
  },

  initialize: function(options){
    _.bindAll(this);
    // window.setTimeout(this.minimize, 10000);
  },

  close: function(){
    console.log("nuclear");
    //TODO tell parent window to remove iframe
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }

});
