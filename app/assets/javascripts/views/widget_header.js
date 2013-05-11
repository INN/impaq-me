window.app.views.WidgetHeader = Backbone.View.extend({
  template: JST['widget_header'],

  events: {
    click: "click"
  },

  initialize: function(options){
    _.bindAll(this);
  },

  click: function(){
    this.model.set('open', !this.model.get('open'));
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }

});
