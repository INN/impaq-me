window.app.helpers.Replacer =
  replace: ($el, model, encodeURI) ->
    _.each model.keys(), (attr) ->
      if attr == 'email_shortlink'
        $el.html $el.html()
          .replace(new RegExp("\%7B\%7Bemail_shortlink\%7D\%7D", 'g'), location.origin + '/' + model.get('email_shortlink'))
      else
        if encodeURI
          $el.html $el.html()
            .replace(new RegExp("{{#{attr}}}", 'g'), encodeURIComponent(model.get(attr)))
            .replace(new RegExp("\%7B\%7B#{attr}\%7D\%7D", 'g'), encodeURIComponent(model.get(attr)))
        else
          $el.html $el.html()
            .replace(new RegExp("{{#{attr}}}", 'g'), model.get(attr))
            .replace(new RegExp("\%7B\%7B#{attr}\%7D\%7D", 'g'), model.get(attr))
