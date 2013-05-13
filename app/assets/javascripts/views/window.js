window.app.views.Window = Backbone.View.extend({
  el: window,

  events: {
    resize: 'resizeParent',
    message: 'wireUpIframeCommunication'
  },

  initialize: function(options){
    _.bindAll(this);
  },

  resizeParent: function(event){
    var data = {
      action: 'resize',
      args: {
        height: $('body').height()
      }
    };
    this.callParent(data);
  },

  closeParent: function(){
    var data = { action: 'close' };
    this.callParent(data);
  },

  callParent: function(data){
    if(!this.publisher) return;

    console.log('talk to parent', data);
    _.extend(data, {widget_id: this.publisher.widget_id});
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
