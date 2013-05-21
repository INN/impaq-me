window.app.views.WidgetFooter = Backbone.View.extend({
  template: JST['widget_footer'],

  initialize: function(options){
    _.bindAll(this);

    this.listenTo(this.model, {
      'change:open':    this.openClose
    });
  },

  openClose: function(model, open_close, options){
    this.$el.toggle(open_close);
    app.events.trigger('change:height');
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }
});
