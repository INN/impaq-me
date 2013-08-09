window.app.views.BannerHeader = class BannerHeader extends Backbone.View
  template: JST["banner_header"]

  render: =>
    @$el.html @template(@model.toJSON())
    this
