window.app.services.Analytics = {
  trackPageview: function(page){
    debugger;
    ga('send', 'pageview', (page ? {page:page} : {}));
  },
  trackSocial: function(network, action, target){
    debugger;
    ga('send', {
      hitType:       'social',
      socialNetwork: network,
      socialAction:  action,
      socialTarget:  target
    });
  }
};

_(app.services.Analytics).extend({
  trackTweet: _.partial(app.services.Analytics.trackSocial, 'twitter', 'tweet'),
  trackLike:  _.partial(app.services.Analytics.trackSocial, 'facebook', 'like'),
  trackEmail: _.partial(app.services.Analytics.trackSocial, 'email', 'email')
});
