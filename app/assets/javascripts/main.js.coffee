$ ->
  init_gallery() if $('.content a > img').length
  init_galleria() if $('#galleria').length
  init_reports() if $('.reports, .documents').length

  if $(".need_collapser").length
    init_collapser()
    hash_handler()

  true
