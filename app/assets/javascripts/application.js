// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. (EDIT: added require_self, so this file is inserted *after* vendor, but before everything else)
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require vendor
//= require_self
//= require_tree ../templates
//= require_tree ./views
//= require_tree ./services
//= require_tree .

// set up namespaces
window.app = {
  models: {},
  views: {},
  services: {}
};

// async 'ready' handlers
window.twttr = (t = { _e: [], ready: function(f){ t._e.push(f); } });
window.fb    = (b = { _e: [], ready: function(f){ b._e.push(f); } });

// facebook doesn't have a multi-handler 'ready' event, so we built one
window.fbAsyncInit = function() {
  fb.ready = function(f){ f(); };
  _.invoke(fb._e, 'call');
};

// verify ready handlers with simple 'sdk loaded' message
twttr.ready(function(){ console.info("twitter sdk loaded"); });
fb.ready(function(){ console.info("facebook sdk loaded"); });

fb.ready(function(){
  FB.init({
    appId: '598072260211923',
    xfbml: true
  });
});

var resizeParent = function(e) {
  var data = {
    widget_id: app.publisher.widget_id,
    height: $('body').height()
  };
  console.log('resize event', e, data);
  app.publisher.window.postMessage(JSON.stringify(data), app.publisher.hostname);
};

var wireUpIframeCommunication = function(e) {
  if(e.originalEvent.origin.match(/localhost/)){
    console.log("message from parent", e);
    window.app.publisher = {
      widget_id: JSON.parse(e.originalEvent.data).widget_id,
      window: e.originalEvent.source,
      hostname: e.originalEvent.origin
    };
    $(window).resize();
  }
};

jQuery(window).on({
  resize: _.debounce(resizeParent, 100),
  message: wireUpIframeCommunication
});
