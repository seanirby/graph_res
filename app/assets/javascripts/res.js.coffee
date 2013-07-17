initialized = false;

initialize = ->
  $(".arrow-up").css("visibility", "hidden")
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

    temp_coeff = $('.active.resistor .temp.selector.band a.active').data('val')
    if temp_coeff != null
      $("#temperature-value").html(temp_coeff)
    else
      $("#temperature-value").html('')

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


decrementBand = ->
  current_band_number = parseInt($("#band-number").html())
  $(".active.resistor").removeClass("active").hide()
  if current_band_number == 5
    $("#four-band.resistor").fadeIn('fast').addClass("active")
    $("#band-number").html("4")
    $(".arrow-up").css("visibility", "hidden")
  else if current_band_number == 6
    $("#five-band.resistor").fadeIn('fast').addClass("active")
    $("#band-number").html("5")
    $(".arrow-down").css("visibility", "visible")

incrementBand = ->
  current_band_number = parseInt($("#band-number").html())
  $(".active.resistor").removeClass("active").hide()
  if current_band_number == 4
    $("#five-band.resistor").fadeIn('fast').addClass("active")
    $("#band-number").html("5")
    $(".arrow-up").css("visibility", "visible")
  else if current_band_number == 5
    $("#six-band.resistor").fadeIn('fast').addClass("active")
    $("#band-number").html("6")
    $(".arrow-down").css("visibility", "hidden")

$(document).ready ->

  $("#input-container .arrow-up").click ->
    decrementBand()
    updateRes()

  $("#input-container .arrow-down").click ->
    incrementBand()
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


