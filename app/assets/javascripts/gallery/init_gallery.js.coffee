@init_gallery = () ->
  images = $('.content a > img')
  images.each (index, item) ->
    $(this).parent('a')
      .attr('rel', 'gallery')
      .attr('title', $(this).attr('title'))
    true
  locale = window.location.pathname.split('/')[1]
  locale = 'ru' unless locale.length
  previous = 'предыдущая'
  next = 'следующая'
  close = 'закрыть'
  if locale == 'en'
    previous = 'previous'
    next = 'next'
    close = 'close'
  images.parent('a').colorbox
    'maxWidth': '90%'
    'maxHeight': '98%'
    'opacity': '0.5'
    'photo': 'true'
    'current': '{current} / {total}'
    'previous': previous
    'next': next
    'close': close
  true
