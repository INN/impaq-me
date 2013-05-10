window.app.views.WidgetHeader = Backbone.View.extend({
  template: JST['widget_header'],

  events: {
  },

  initialize: function(options){
    _.bindAll(this);
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});
