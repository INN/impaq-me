window.app.views.WidgetFooter = Backbone.View.extend({
  template: JST['widget_footer'],

  initialize: function(options){
    _.bindAll(this);

    this.listenTo(this.model, {
      'change:open':    this.openClose
    });
  },

  openClose: function(model, open_close, options){
    this.$el.slide(open_close);
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }
});
