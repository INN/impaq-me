window.app.views.Widget = Backbone.View.extend({
  initialize: function(options){
    this.views = $.extend({}, {
      header: new app.views.WidgetHeader().render(),
      share:  new app.views.Share().render(),
      body:   new app.views.WidgetBody().render()
    });
  },

  render: function(){
  }
});
