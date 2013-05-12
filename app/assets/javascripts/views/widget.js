window.app.views.Widget = Backbone.View.extend({

  initialize: function(options){
    _.bindAll(this);

    this.views = $.extend({}, {
      header: new app.views.WidgetHeader({model: this.model}),
      share:  new app.views.Share({model: this.model}),
      body:   new app.views.WidgetBody({model: this.model})
    });

    this.listenTo(this.model, {
      'change:mode':    this.changeMode,
      'change:tweeted': this.open,
      'change:liked':   this.open
    });
  },

  changeMode: function(model, mode, options){
    this.views.header.$el.toggle(mode === "widget");
  },

  open: function(){
    this.model.set('open', true);
  },

  render: function(){
    this.assign({
      "[data-subview='WidgetHeader']" : this.views.header,
      "[data-subview='Share']"        : this.views.share,
      "[data-subview='WidgetBody']"   : this.views.body
    });
    return this;
  }
});
