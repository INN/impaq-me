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

fb.ready(function(){ FB.init({
  xfbml: true
}); });
