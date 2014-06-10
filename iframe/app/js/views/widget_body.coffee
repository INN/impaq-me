window.app.views.WidgetBody = class WidgetBody extends Backbone.View
  template: JST["app/templates/widget_body.us"]

  events:
    "submit form.paypal": "paypalDonation"

  initialize: (options) ->
    @listenTo @model,
      "change:open": @openChanged

    @listenTo app.events,
      "share:twitter": @thanks
      "share:facebook": @thanks
      "share:email": @thanks

  paypalDonation: =>
    app.services.Analytics.trackEvent "followup_cta", "click", "paypal_donate"

  openChanged: (model, open_close, options) =>
    @$el.toggle open_close

  thanks: =>
    @$(".solicit").fadeOut().promise().then =>
      @$(".thanks").fadeIn()

  render: =>
    @$el.html @template(@model.toJSON())
    window.app.helpers.Replacer.replace @$el, @model
    @$(".thanks").hide()
    this
