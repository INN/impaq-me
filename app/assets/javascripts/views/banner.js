window.app.views.Banner = Backbone.View.extend({
  template: JST['banner'],

  events: {
    "click button": "close",
    click: "openWidget" //TODO handle repeat clicks
  },

  initialize: function(options){
    _.bindAll(this);
    window.setTimeout(this.minimize, 10000);
  },

  close: function(){
    console.log("nuclear");
    //TODO tell parent window to remove iframe
  },

  maximize: function(){
    this.$('.thanks').slideDown();
    this.is_maximized = true;
    return this;
  },

  minimize: function(){
    this.$('.thanks').slideUp();
    this.is_maximized = false;
    return this;
  },

  openWidget: function(){
    app.views.banner_widget.open();
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});
