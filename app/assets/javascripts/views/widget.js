window.app.views.Widget = Backbone.View.extend({

  initialize: function(options){
    _.bindAll(this);

    this.views = $.extend({}, {
      header: new app.views.WidgetHeader({model: this.model}).render(),
      share:  new app.views.Share({model: this.model}).render(),
      body:   new app.views.WidgetBody({model: this.model}).render()
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
    this.$el.empty()
      .append(this.views.header.el)
      .append(this.views.share.el)
      .append(this.views.body.el);
    return this;
  }
});
