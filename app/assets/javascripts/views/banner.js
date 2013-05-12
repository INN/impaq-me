window.app.views.Banner = Backbone.View.extend({
  template: JST['banner'],

  events: {
  },

  initialize: function(options){
    _.bindAll(this);

    this.views = $.extend({}, {
      header: new app.views.BannerHeader({model: this.model}),
      info: new app.views.BannerInfo({model: this.model})
    });
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

    this.assign({
      "[data-subview='BannerHeader']" : this.views.header,
      "[data-subview='BannerInfo']"   : this.views.info
    });
    return this;
  }

});
