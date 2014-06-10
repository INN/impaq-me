window.app.views.BannerHeader = class BannerHeader extends Backbone.View
  template: new window.app.Template("banner_header")

  render: =>
    @$el.html @template.fill(@model.toJSON())
    this
