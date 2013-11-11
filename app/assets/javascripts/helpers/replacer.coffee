window.app.helpers.Replacer =
  replace: ($el, model) ->
    _.each model.keys(), (attr) ->
      $el.html $el.html()
        .replace(new RegExp("{{#{attr}}}", 'g'), model.get(attr))
