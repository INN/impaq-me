window.app.views.WidgetBody = Backbone.View.extend({
  template: JST['widget_body'],

  initialize: function(){
    _.bindAll(this);
  },

  // open: function(){
  //   this.$el.slideDown();
  //   this.is_open = true;
  // },

  // close: function(){
  //   this.$el.slideUp();
  //   this.is_open = false;
  // },

  // toggle: function(){
  //   this.is_open ? this.close() : this.open();
  // },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});
