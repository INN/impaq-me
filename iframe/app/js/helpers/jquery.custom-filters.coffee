jQuery.expr[':'].visibilityHidden = (el) ->
  $(el).css('visibility') is 'hidden'
