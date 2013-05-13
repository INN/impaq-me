window.app.views.Banner = Backbone.View.extend({
  template: JST['banner'],

  events: {
    click: "click"
  },

  initialize: function(options){
    _.bindAll(this);

    this.views = $.extend({}, {
      header: new app.views.BannerHeader({model: this.model}),
      info: new app.views.BannerInfo({model: this.model}),
      close: new app.views.BannerClose({model: this.model})
    });
  },

  maximize: function(){
    this.views.info.$el.slideDown();
    this.$el.removeClass('minimized').addClass('maximized');
    return this;
  },

  minimize: function(){
    this.views.info.$el.slideUp();
    this.$el.removeClass('maximized').addClass('minimized');
    return this;
  },

  click: function(){
    this.model.set('open', !this.model.get('open'));
  },

  render: function(){
    window.setTimeout(this.minimize, 10000);

    this.$el.html(this.template(this.model.toJSON()));
    this.assign({
      "[data-subview='BannerHeader']" : this.views.header,
      "[data-subview='BannerInfo']"   : this.views.info,
      "[data-subview='BannerClose']"  : this.views.close
    });
    return this;
  }

});
