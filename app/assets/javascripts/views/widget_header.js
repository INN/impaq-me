window.app.views.WidgetHeader = Backbone.View.extend({
  template: JST['widget_header'],

  events: {
    click: "toggle"
  },

  initialize: function(options){
    _.bindAll(this);
  },

  toggle: function(){
    app.views.widget_body.toggle();
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});
