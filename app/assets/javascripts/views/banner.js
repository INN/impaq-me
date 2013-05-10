window.app.views.Banner = Backbone.View.extend({
  template: JST['banner'],

  events: {
  },

  initialize: function(options){
    _.bindAll(this);
  },

  maximize: function(){
    this.views.info.$el.slideDown();
    return this;
  },

  minimize: function(){
    this.views.info.$el.slideUp();
    return this;
  },

  render: function(){
    window.setTimeout(this.minimize, 10000);

    this.views = $.extend({}, {
      header: new app.views.BannerHeader().render(),
      info: new app.views.BannerInfo().render()
    });

    this.$el.empty()
      .append(this.views.info.el)
      .append(this.views.header.el);
    return this;
  }

});
