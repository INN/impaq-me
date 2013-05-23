window.app.services.Analytics = {

  trackPageview: function(page){
    ga('send', 'pageview', (page ? {page:page} : {}));
  },

  trackEvent: function(category, action, label, value, nonInteractive){
    ga('send', {
      hitType: 'event',
      eventCategory: category,
      eventAction: action,
      eventLabel: label,
      eventValue: value,
      nonInteraction: nonInteractive
    });
  },

  trackSocial: function(network, action, target){
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
