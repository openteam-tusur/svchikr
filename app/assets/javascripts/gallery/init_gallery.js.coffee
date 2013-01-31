@init_gallery = () ->
  images = $('.content a > img')
  return true if images.closest('.actual_info').length
  images.each (index, item) ->
    href = $(item).parent('a').attr('href')
    if href.endsWith(/[\.png|\.jpg|\.jpeg]$/i)
      $(this).parent('a')
        .attr('rel', 'gallery')
        .attr('title', $(this).attr('title'))
    true
  $(images).parent('a[rel=gallery]').colorbox
    'maxWidth': '90%'
    'maxHeight': '98%'
    'opacity': '0.5'
    'photo': 'true'
    'current': '{current} / {total}'
  true
