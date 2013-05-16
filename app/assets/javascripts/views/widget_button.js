window.app.views.WidgetButton = Backbone.View.extend({
  events: {
    click: 'click'
  },

  initialize: function(options){ },

  click: function(e){
    this.model.set('open', !this.model.get('open'));
  },

  render: function(){
    this.$el.html('<button class="toggle">');
    return this;
  }
});
