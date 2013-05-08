window.app.views.Window = Backbone.View.extend({
  el: window,

  events: {
    resize: 'resizeParent',
    message: 'wireUpIframeCommunication'
  },

  resizeParent: function(event){
    var data = {
      widget_id: this.publisher.widget_id,
      height: $('body').height()
    };
    console.log('resize event', event, data);
    this.publisher.window.postMessage(JSON.stringify(data), this.publisher.hostname);
  },

  wireUpIframeCommunication: function(event){
    if(!event.originalEvent.origin.match(/localhost/)) return;
    console.log("message from parent", event);

    this.publisher = {
      widget_id: JSON.parse(event.originalEvent.data).widget_id,
      window: event.originalEvent.source,
      hostname: event.originalEvent.origin
    };

    this.$el.resize();
  }

});
