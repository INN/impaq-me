Backbone.View::assign = (selector, view) ->
  if _.isObject(selector)
    selectors = selector
  else
    selectors = {}
    selectors[selector] = view

  _(selectors).each (view, selector) ->
    view.setElement(@$(selector)).render()
  , this
