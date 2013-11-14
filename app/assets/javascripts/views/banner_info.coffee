window.app.views.BannerInfo = class BannerInfo extends Backbone.View
  template: new window.app.Template("banner_info")

  render: =>
    @$el.html @template.fill(@model.toJSON())
    window.app.helpers.Replacer.replace @$el, @model
    this
