window.app.views.BannerInfo = class BannerInfo extends Backbone.View
  template: JST["banner_info"]

  render: =>
    @$el.html @template(@model.toJSON())
    this
