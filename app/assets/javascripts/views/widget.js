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
      'change:mode':    this.modeChanged,
      'change:open':    this.openChanged
    });

    this.listenTo(app.events, {
      'share:twitter':  this.shared,
      'share:facebook': this.shared,
      'share:email':    this.shared
    });
  },

  modeChanged: function(model, mode, options){
    app.events.trigger('change:height');
  },

  openChanged: function(model, open, options){
    this.$("#widget .unnamed")
      .css({ margin: (open ? '12px 0 -4px' : 0) }).promise()
      .then(function(){ app.events.trigger('change:height')});
  },

  shared: function(){
    this.model.set('open', true);
    app.events.trigger('change:height');
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
