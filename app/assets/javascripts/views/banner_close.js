window.app.views.BannerClose = Backbone.View.extend({
  events: {
    click: "close",
  },

  initialize: function(options){
    _.bindAll(this);
  },

  close: function(){
    console.log("nuclear");
    //TODO tell parent window to remove iframe
  },

  render: function(){
    this.$el.html('<button class="close"><i class="icon-remove-sign" title="close"></i></button>');
    return this;
  }
});
