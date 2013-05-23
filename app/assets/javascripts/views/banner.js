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

    this.listenTo(this.model, {
      'change:minimize': this.minimize,
    });
  },

  maximize: function(){
    this.views.info.$el.show();
    return this;
  },

  minimize: function(){
    this.views.info.$el.hide();
    return this;
  },

  click: function(){
    clearTimeout(this.minimizer);
    this.model.set('open', !this.model.get('open'));
    app.services.Analytics.trackEvent('widget', (this.model.get('open') ? 'open' : 'close'), 'banner');
  },

  timeout: function(){
    this.minimize();
    app.services.Analytics.trackEvent('banner', 'minimize', 'timeout', undefined, true);
  },

  render: function(){
    this.minimizer = window.setTimeout(this.timeout, 10000);

    this.$el.html(this.template(this.model.toJSON()));
    this.assign({
      "[data-subview='BannerHeader']" : this.views.header,
      "[data-subview='BannerInfo']"   : this.views.info,
      "[data-subview='BannerClose']"  : this.views.close
    });
    return this;
  }

});
