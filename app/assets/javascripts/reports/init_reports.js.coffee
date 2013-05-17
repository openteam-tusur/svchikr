@init_reports = ->
  $('div.content div.reports').each (index, report) ->
    # return false if $('li a span.icon', $(report)).length
    $('li a', $(report)).each (index, link) ->
      $link = $(link)
      href = $link.attr 'href'
      href = href.substr 0, href.lastIndexOf('?') if href.indexOf('?') > 0
      extension = (href.substr href.lastIndexOf('.') + 1).toLowerCase()
      $link.attr class: extension
      $link.prepend($('<span class=\'icon\'>&nbsp;</span>')) unless $('span.icon', $link).length
