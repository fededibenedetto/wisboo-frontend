load 'channels#index', (controller, action) ->
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()

  $('#courseCarousel').carousel interval: 4000
  $('#courseCarousel.carousel .item').each ->
    next = $(this).next()
    next = $(this).siblings(':first')  unless next.length
    next.children(':first-child').clone().appendTo $(this)
    i = 0

    while i < 2
      next = next.next()
      next = $(this).siblings(':first')  unless next.length
      next.children(':first-child').clone().appendTo $(this)
      i++

  $('a.cursos').click (e) ->
    e.preventDefault();
    $('html, body').animate({
        scrollTop: $("#channel-menu").offset().top
    }, 700);
    $('#channel-info').hide(700)
    $('.login-in-tab').removeClass('hide')
