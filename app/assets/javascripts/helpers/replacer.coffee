window.app.helpers.Replacer =
  replace: ($el, model) ->
    _.each model.keys(), (attr) ->
      $el.html $el.html()
        .replace("{{#{attr}}}", model.get(attr))
