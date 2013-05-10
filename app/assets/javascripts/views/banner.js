window.app.views.Banner = Backbone.View.extend({
  template: JST['banner'],

  initialize: function(options){
    _.bindAll(this);

    this.views = $.extend({}, {
      header: new app.views.BannerHeader().render(),
      info: new app.views.BannerInfo().render()
    });

    // window.setTimeout(this.minimize, 10000);
  },

  events: {
    // "click button": "close",
    // click: "openWidget" //TODO handle repeat clicks
  },

  // close: function(){
  //   console.log("nuclear");
  //   //TODO tell parent window to remove iframe
  // },

  maximize: function(){
    this.views.info.$el.slideDown();
    // this.is_maximized = true;
    return this;
  },

  minimize: function(){
    this.views.info.$el.slideUp();
  //   this.is_maximized = false;
    return this;
  },

  // openWidget: function(){
  //   app.views.banner_widget.open();
  // },

  render: function(){
    this.$el.empty()
      .append(this.views.header.el)
      .append(this.views.info.el);
    return this;
  }

});
