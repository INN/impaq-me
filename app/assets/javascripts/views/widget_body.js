window.app.views.WidgetBody = Backbone.View.extend({
  template: JST['widget_body'],

  initialize: function(){
    _.bindAll(this);
  },

  thanks: function(){
    this.$("#solicit").fadeOut();
    this.$("#thanks").fadeIn();
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    this.$("#thanks").hide();
    return this;
  }
});
