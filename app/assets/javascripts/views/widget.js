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
      'change:open':    this.openChange,
      'change:tweeted': this.open,
      'change:liked':   this.open,
      'change:emailed': this.open
    });
  },

  open: function(){
    this.model.set('open', true);
  },

  openChange: function(model, open_close, options){
    this.$("#widget .unnamed").animate({ margin: (open_close ? '12px 0 -4px' : 0) });
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
