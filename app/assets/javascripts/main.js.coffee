$ ->
  init_gallery() if $('.content a > img').length
  init_galleria() if $('#galleria').length

  if $(".need_collapser").length
    init_collapser()
    hash_handler()

  true
