@init_gallery = () ->
  images = $('.content a:not(.no_cbox) > img')
  return true if images.closest('.actual_info').length
  images.each (index, item) ->
    href = $(item).parent('a').attr('href')
    if href.endsWith(/[\.png|\.jpg|\.jpeg]$/i)
      $(this).parent('a')
        .attr('rel', 'gallery')
        .attr('title', $(this).attr('title'))
    true
  links = $(images).parent('a[rel=gallery]')
  links.colorbox(
    'maxWidth': '90%'
    'maxHeight': '98%'
    'opacity': '0.5'
    'photo': 'true'
    'current': '{current} / {total}'
  ) if links.length
  true
