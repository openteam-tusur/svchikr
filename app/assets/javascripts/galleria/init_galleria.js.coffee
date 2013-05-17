@init_galleria = ->
  $('#galleria').galleria({
    width: 940,
    imageCrop: 'width',
    thumbCrop: true,
    transitionSpeed: 500,
    preload: 3,
    easing: "galleriaIn",
    showCounter: false,
    transition: "fade",
    transitionInitial: "fade",
    showInfo: true,
    showFullscreen: true
  })

@init_slider = ->
  actual = $(".actual")
  slider = $(".switcher", actual)
  info_wrapper = $("<div />", { class: "info_wrapper" }).appendTo(actual)
  info = $("<div />", { class: "info" }).appendTo(info_wrapper)
  text = $("<div />", { class: "text" }).appendTo(info)
  dots = $("<div />", { class: "dots" }).appendTo(info)
  $("li", slider).each (index, element) ->
    $(element).addClass("dot#{index}")
    $("<span />", { id: "dot#{index}" }).prependTo dots
  text.html($("li:last img", slider).attr("data-title"))
  $("span:first", dots).addClass("active")
  $("span", dots).click ->
    return false if $(this).hasClass("active")
    klass = $(this).attr("id")
    target = $("li.#{klass}", slider)
    change_slide(target)
  return false if $("li", slider).length < 2
  timer()

change_slide = (target) ->
  clearInterval(@timeout_interval)
  slider = target.closest(".switcher")
  img = $("img", target)
  text = $(".text", target.closest(".actual"))
  dots = $(".dots", target.closest(".actual"))
  text.html(img.attr("data-title"))
  $("##{target.attr('class')}", dots).addClass("active").siblings("span").removeClass("active")
  target.hide().appendTo(slider).stop(true,true).fadeIn 500, ->
    timer()

auto_change = ->
  current_dot = $(".actual .info .dots .active")
  next_dot = if current_dot.next().length then current_dot.next() else $(".actual .info .dots span:first")
  next_li = $(".actual .switcher li.#{next_dot.attr('id')}")
  change_slide(next_li)

timer = ->
  @timeout_interval = setTimeout(auto_change, 15000)
