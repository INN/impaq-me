window.app.views.Window = Backbone.View.extend({
  el: window,

  events: {
    resize: 'resizeParent',
    message: 'iframeCommunication'
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

    // console.log('talk to parent', data);
    _.extend(data, {widget_id: this.publisher.widget_id});
    this.publisher.window.postMessage(JSON.stringify(data), this.publisher.hostname);
  },

  iframeCommunication: function(event){
    if(!event.originalEvent.origin.match(this.model.get('article_domain'))) return;

    //TODO stop parsing this twice
    if(JSON.parse(event.originalEvent.data).action === "minimize"){
      app.models.widget.set('minimize', 'true')
      console.log("min message from parent", event);
    } else {
      console.log("init message from parent", event);
      this.wireUpIframeCommunication(event);
    }
  },

  wireUpIframeCommunication: function(event){
    this.publisher = {
      widget_id: JSON.parse(event.originalEvent.data).widget_id,
      window: event.originalEvent.source,
      hostname: event.originalEvent.origin
    };

    this.$el.resize();
  }
});
