window.app.views.Widget = Backbone.View.extend({
  template: JST['widget'],

  initialize: function(options){
    _.bindAll(this);

    this.views = {
      header: new app.views.WidgetHeader({model: this.model}),
      share:  new app.views.Share({model: this.model}),
      body:   new app.views.WidgetBody({model: this.model}),
      footer: new app.views.WidgetFooter({model: this.model})
    };

    this.listenTo(this.model, {
      'change:open':    this.openChanged,
      'change:tweeted': this.open,
      'change:liked':   this.open,
      'change:emailed': this.open
    });
  },

  open: function(){
    this.model.set('open', true);
  },

  openChanged: function(model, open, options){
    this.$("#widget .unnamed")
      .animate({ margin: (open ? '12px 0 -4px' : 0) }).promise()
      .then(function(){ app.events.trigger('change:height')});
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
