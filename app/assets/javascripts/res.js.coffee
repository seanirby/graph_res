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

    multiplier_symbol = ''
    if multiplier == 0.1
      resistance = digits/10
    else if multiplier == 0.01
      resistance = digits/100
    else
      resistance = digits * multiplier

    if resistance > 999 && resistance < 1000000
      resistance = resistance/1000
      multiplier_symbol = 'k'
    else if resistance >= 1000000
      resistance = resistance/1000000
      multiplier_symbol = "M"

    tolerance = $('.active.resistor .tolerance.selector.band a.active').data("val")
    $("#resistance-sig-figs").html("#{resistance}")
    $("#resistance-units").html("#{multiplier_symbol}&#8486")
    $("#tolerance-value").html("&plusmn #{tolerance}")
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

showGlimpse = ->
  setTimeout(
    ->
      $(".active.resistor .band_container").trigger("mouseover")
    2000
  )
  setTimeout(
    ->
      $(".active.resistor .band_container").trigger("mouseleave")
    4000
  )

$(document).ready ->

  $("#input-container .arrow-up").click ->
    decrementBand()
    updateRes()

  $("#input-container .arrow-down").click ->
    incrementBand()
    updateRes()

  $(".band_container").hover(
    ->
      clearTimeout($(this).data('timeout'));
      $(this).children(".band:first").hide()
      $(this).children(".band:last").fadeIn('fast')
    ->
      elem = this;
      t = setTimeout( ->
        $(elem).children(".band:last").hide()
        $(elem).children(".band:first").fadeIn('fast')
      150);
      $(this).data('timeout', t);
  )

  $(".block").click ->
    $(this).parent().children(".active").removeClass("active")
    $(this).addClass("active")
    color = $(this).css("backgroundColor")
    image = $(this).css("backgroundImage")
    band = $(this).closest(".band_container").children(":first")
    band.css("backgroundColor", color)
    band.css("backgroundImage", image)
    updateRes()

  #Initialize resistor values with random selection
  initialize()

  #Give a glimpse of the selectors
  showGlimpse()

