window.app.views.Widget = Backbone.View.extend({

  initialize: function(options){
    _.bindAll(this);

    this.views = $.extend({}, {
      header: new app.views.WidgetHeader().render(),
      share:  new app.views.Share().render(),
      body:   new app.views.WidgetBody().render()
    });
  },

  open: function(){
    this.views.body.$el.slideDown();
    return this;
  },

  close: function(){
    this.views.body.$el.slideUp();
    return this;
  },

  render: function(){
    this.$el.empty()
      .append(this.views.header.el)
      .append(this.views.share.el)
      .append(this.views.body.el);
    return this;
  }
});
