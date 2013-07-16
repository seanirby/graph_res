$(document).ready ->

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
    color = $(this).css("background")
    band = $(this).closest(".band_container").children(":first")
    console.log(band)
    console.log(color)
    band.css("background", color)
    #recalculate resistance for active resistor
