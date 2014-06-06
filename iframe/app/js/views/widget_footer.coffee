window.app.views.WidgetFooter = class WidgetFooter extends Backbone.View
  template: JST["app/templates/widget_footer.us"]

  events:
    "click .about-funding": "aboutFundingClicked"
    "click .about-impaqme": "aboutImpaqmeClicked"

  initialize: (options) ->
    @listenTo @model,
      "change:open": @openChanged

  openChanged: (model, open_close, options) =>
    @$el.toggle open_close

  aboutFundingClicked: =>
    app.services.Analytics.trackEvent "footer", "click", "about_funding"

  aboutImpaqmeClicked: =>
    app.services.Analytics.trackEvent "footer", "click", "about_impaqme"

  render: =>
    @$el.html @template(@model.toJSON())
    this
