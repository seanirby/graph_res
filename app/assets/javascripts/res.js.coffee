#Initialize

$(document).ready ->

  $("#controls a").click (e) ->
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