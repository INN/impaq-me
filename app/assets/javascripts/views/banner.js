window.app.views.Banner = Backbone.View.extend({
  template: JST['banner'],

  events: {
    // click: "openWidget" //TODO handle repeat clicks
  },

  initialize: function(options){
    _.bindAll(this);

    this.views = $.extend({}, {
      header: new app.views.BannerHeader().render(),
      info: new app.views.BannerInfo().render()
    });

    window.setTimeout(this.minimize, 10000);
  },

  maximize: function(){
    this.views.info.$el.slideDown();
    return this;
  },

  minimize: function(){
    this.views.info.$el.slideUp();
    return this;
  },

  // openWidget: function(){
  //   app.views.banner_widget.open();
  // },

  render: function(){
    this.$el.empty()
      .append(this.views.info.el)
      .append(this.views.header.el);
    return this;
  }

});
