window.app.views.WidgetButton = Backbone.View.extend({
  events: {
    click: 'click'
  },

  initialize: function(options){
    _.bindAll(this);

    this.listenTo(this.model, {
      'change:open':    this.openChanged
    });
  },

  click: function(e){
    this.model.set('open', !this.model.get('open'));
    app.services.Analytics.trackEvent('widget', (this.model.get('open') ? 'open' : 'close'), 'secondary_button');
  },

  openChanged: function(model, open, options){
    this.$el.toggleClass('opened', open);
  },

  render: function(){
    this.$el.html('<button class="toggle">');
    return this;
  }
});
