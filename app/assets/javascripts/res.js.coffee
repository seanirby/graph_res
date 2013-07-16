

  #get first two digits
    #if 5 or 6 band
      #push another digit onto digits array


$(document).ready ->

  getRes = () ->
    digits = $('.active.resistor .digit.selector.band a.active').map ->
      return $(this).data("val")
    digits = parseInt(digits.get().join(''))

    multiplier = $('.active.resistor .multiplier.selector.band a.active').data("val")
    multiplier = parseInt(multiplier.get())

    resistance = digits * multiplier
    #tolerance = $('.active.resistor .tolerance.selector.band a.active').data("val")
    $("#output").html(resistance)

  console.log(getRes)

  $("#controls a").click ->
    type = $(this).data("type")
    $(".active.resistor").removeClass("active").hide()
    $("##{type}").fadeIn('fast').addClass("active")

  $(".band_container").hover(
    ->
      $(this).children(".band:first").hide()
      $(this).children(".band:last").fadeIn('fast')
    ->
      $(this).children(".band:last").hide()
      $(this).children(".band:first").fadeIn('fast')
  )

  $(".block").click ->
    #get previous selected block in this band and remove active class
    #add active class to this block
    $(this).parent().children(".active").removeClass("active")
    $(this).addClass("active")

    #change color
    color = $(this).css("background-color")
    band = $(this).closest(".band_container").children(":first")
    console.log(color)
    band.css("background", color)
    getRes()
    #recalculate resistance for active resistor



