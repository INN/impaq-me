window.app.views.Window = Backbone.View.extend({
  el: window,

  events: {
    resize: 'resizeParent',
    message: 'iframeCommunication'
  },

  initialize: function(options){
    _.bindAll(this);

    this.listenTo(app.events, {
      'change:height': this.resizeParent
    });
  },

  fullHeight: function(){
    var main = $('main').height();
    var fb_iframe = $('.facebook iframe');
    if(fb_iframe.length){
      var fb = fb_iframe.height() + fb_iframe.offset().top;
    }
    return Math.max(main, fb || 0);
  },

  resizeParent: _.debounce(function(){
    var data = {
      action: 'resize',
      args: {
        height: this.fullHeight()
      }
    };
    this.callParent(data);
  }, 50),

  closeParent: function(){
    var data = { action: 'close' };
    this.callParent(data);
  },

  callParent: function(data){
    if(!this.publisher) return;

    _.extend(data, {widget_id: this.publisher.widget_id});
    this.publisher.window.postMessage(JSON.stringify(data), this.publisher.hostname);
  },

  iframeCommunication: function(event){
    if(!event.originalEvent.origin.match(this.model.get('article_domain'))) return;

    if(JSON.parse(event.originalEvent.data).action === "minimize"){
      app.models.widget.set('minimize', 'true');
      app.services.Analytics.trackEvent('banner', 'minimize', 'scroll', undefined, true);
    } else {
      this.wireUpIframeCommunication(event);
    }
  },

  wireUpIframeCommunication: function(event){
    this.publisher = {
      widget_id: JSON.parse(event.originalEvent.data).widget_id,
      window: event.originalEvent.source,
      hostname: event.originalEvent.origin
    };

    this.resizeParent();
  }
});
