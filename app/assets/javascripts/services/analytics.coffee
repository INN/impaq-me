window.app.services.Analytics = class Analytics
  @trackPageview: (page) ->
    ga "send", "pageview", (if page then page: page else {})

  @trackEvent: (category, action, label, value, nonInteractive) ->
    ga "send",
      hitType: "event"
      eventCategory: category
      eventAction: action
      eventLabel: label
      eventValue: value
      nonInteraction: nonInteractive

  @trackSocial: (network, action, target) ->
    ga "send",
      hitType: "social"
      socialNetwork: network
      socialAction: action
      socialTarget: target

  @trackTweet: _(Analytics.trackSocial).partial("twitter", "tweet")
  @trackLike: _(Analytics.trackSocial).partial("facebook", "like")
  @trackEmail: _(Analytics.trackSocial).partial("email", "email")
