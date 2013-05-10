window.app.views.WidgetBody = Backbone.View.extend({
  template: JST['widget_body'],

  initialize: function(){
    _.bindAll(this);
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});
