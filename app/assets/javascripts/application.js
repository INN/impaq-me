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

jQuery(document).ready(function($){
  $(window).on('resize', _.debounce(function(e){
    console.log('resize event', e, $('body').height());

    app.publisher.window.postMessage($('body').height(), app.publisher.hostname);
  }, 300));
});

$(window).on('load', function(e){ console.log("window loaded"); });
$(window).on('message', function(e){
  if(e.originalEvent.origin.match(/localhost/)){
    console.log("message from parent", e);
    window.app.publisher = {
      window: e.originalEvent.source,
      hostname: e.originalEvent.origin
    };
  }
});
