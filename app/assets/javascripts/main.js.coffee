$ ->
  init_gallery() if $('.content a > img').length

  if $(".need_collapser").length
    init_collapser()
    hash_handler()

  true
