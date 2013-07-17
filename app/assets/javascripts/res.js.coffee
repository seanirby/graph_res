initialized = false;
initialize = ->
  $(".resistor .selector").each ->
    size = $(this).children().size()
    rand_index = Math.round(Math.random()*(size-1))
    $(this).children(":eq(#{rand_index})").trigger("click")
    initialized = true;
    updateRes()

updateRes = ->
  if initialized == true
    $("#output-container").hide()
    digits = $('.active.resistor .digit.selector.band a.active').map ->
      return $(this).data("val")
    digits = parseFloat(digits.get().join(''))

    multiplier = parseFloat($('.active.resistor .multiplier.selector.band a.active').data("val"))

    if multiplier == 0.1
      resistance = digits/10
    else if multiplier == 0.01
      resistance = digits/100
    else
      resistance = digits * multiplier

    if resistance > 999 && resistance < 1000000
      resistance = (resistance/1000) + "k"
    else if resistance >= 1000000
      resistance = (resistance/1000000) + "M"

    tolerance = $('.active.resistor .tolerance.selector.band a.active').data("val")
    $("#resistance-value").html("#{resistance}&#8486")
    $("#tolerance-value").html("#{tolerance}")
    $("#output-container").fadeIn('fast')

$(document).ready ->

  $("#controls a").click ->
    type = $(this).data("type")
    $(".active.resistor").removeClass("active").hide()
    $("##{type}").fadeIn('fast').addClass("active")
    updateRes()

  $(".band_container").hover(
    ->
      $(this).children(".band:first").hide()
      $(this).children(".band:last").fadeIn('fast')
    ->
      $(this).children(".band:last").hide()
      $(this).children(".band:first").fadeIn('fast')
  )

  $(".block").click ->
    $(this).parent().children(".active").removeClass("active")
    $(this).addClass("active")
    color = $(this).css("background")
    band = $(this).closest(".band_container").children(":first")
    band.css("background", color)
    updateRes()

  initialize()


