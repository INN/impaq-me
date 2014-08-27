#= require vendor_performance

$ ->
  return unless $('#performance_page').length
  Pizza.init document.body,
    show_text: false
    # donut: false,
    # donut_inner_ratio: 0.4
    # percent_offset: 30
    # stroke_color: '#333'
    # stroke_width: 0
    # animation_speed: 500
    # animation_type: 'elastic'
