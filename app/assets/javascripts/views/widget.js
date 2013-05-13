window.app.views.Widget = Backbone.View.extend({
  template: JST['widget'],

  initialize: function(options){
    _.bindAll(this);

    this.views = $.extend({}, {
      header: new app.views.WidgetHeader({model: this.model}),
      share:  new app.views.Share({model: this.model}),
      body:   new app.views.WidgetBody({model: this.model}),
      footer: new app.views.WidgetFooter({model: this.model})
    });

    this.listenTo(this.model, {
      'change:tweeted': this.open,
      'change:liked':   this.open
    });
  },

  open: function(){
    this.model.set('open', true);
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    this.assign({
      "[data-subview='WidgetHeader']" : this.views.header,
      "[data-subview='Share']"        : this.views.share,
      "[data-subview='WidgetBody']"   : this.views.body,
      "[data-subview='WidgetFooter']" : this.views.footer
    });
    return this;
  }
});
