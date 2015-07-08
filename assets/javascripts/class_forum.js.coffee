load "units#show", (controller, action) ->
    canContinue = true
    activeslide = $("#contents-carousel .active");

    $(document).ready ->
      $("[data-toggle=\"tooltip\"]").tooltip()
      toggleCarouselArrows()
    # Initalize the "slide" title
    $("#carousel-text>h4").text $("#contents-carousel .active").data("slide-title")

    # Initalize the carousels setting the interval to none
    # This could also be done by just setting the data-interval to 0 in the markup
    $("#contents-carousel, #numberCarousel").carousel interval: 0

    # Make the thumbnail slider increment one at at time
    $(".carousel[data-type=\"multi\"] .item").each ->
      next = $(this).next()
      next = $(this).siblings(":first")  unless next.length
      next.children(":first-child").clone().appendTo $(this)
      i = 0

      while i < 4
        next = next.next()
        next.children(":first-child").clone().appendTo $(this)
        i++

    # When the carousel slides, auto update the text
    $("#contents-carousel").on "slid.bs.carousel", ->
      activeslide = $(this).find(".active")
      canContinue = (activeslide.find('.question').length==0)
      $("#carousel-text>h4").text activeslide.data("slide-title")
      $("#numberCarousel").carousel activeslide.index()
      toggleCarouselArrows()

    # Collapse accordion every time dropdown is shown
    $(".dropdown-accordion").on "show.bs.dropdown", (event) ->
      accordion = $(this).find($(this).data("accordion"))
      accordion.find(".panel-collapse.in").collapse "hide"

    # Prevent dropdown to be closed when we click on an accordion link
    $(".dropdown-accordion").on "click", "a[data-toggle=\"collapse\"]", (event) ->
      event.preventDefault()
      event.stopPropagation()
      $($(this).data("parent")).find(".panel-collapse.in").collapse "hide"
      $($(this).attr("href")).collapse "show"

    $("a#course-landing").click ->
      $(this).prop("href", $(this).prop("href") + '&content_index=' + currentContent())

    $(".chng-content").click ->
      stopVideo()

    stopVideo = ->
      video = $(".item.active iframe")[0]
      video.src = video.src if video

    $('#next-content').click ->
      sendContentProgress(currentContent())
      canAccessContent(nextContent())
      updateProgress()

    $('#prev-content').click ->
      canAccessContent(prevContent())

    $('.last-content').click ->
      sendContentProgress(currentContent())
      updateProgress()
      if $(this).hasClass('end-course')
        $(this).addClass('hide')

    $('.carousel-number').click ->
      contentIndex = $(this).data('content-index')
      if (contentIndex)
        canAccessContent(contentIndex)

    $('.go-to-exercise').click ->
      prevContentIndex = $(this).data('slide-to') - 1
      sendContentProgress(prevContentIndex)
      updateProgress()

    $(".new_content_response").on("ajax:success", (e, data, status, xhr) ->
      question_div = ".question-" + xhr.responseJSON.content_question_id
      $(question_div + " .alert-correct").removeClass("hidden")
      $(question_div + " .alert-incorrect").addClass("hidden")
      $(question_div + " .alert-warning").addClass("hidden")
      updateProgress()
      canContinue = true
    ).on "ajax:error", (e, xhr, status, error) ->
      question_div = ".question-" + xhr.responseJSON.content_question_id
      $(question_div + " .alert-correct").addClass("hidden")
      $(question_div + " .alert-incorrect").removeClass("hidden")
      $(question_div + " .alert-warning").addClass("hidden")

    toggleCarouselArrows = ->
      $('#prev-content').toggleClass('hide', isFirstContent())
      $('#prev-unit').toggleClass('hide', !isFirstContent())
      $('#next-content').toggleClass('hide', isLastVisibleContent())
      $('#next-unit').toggleClass('hide', !isLastContent())

    canAccessContent = (contentIndex) ->
      url = $('*[data-content-index="' + contentIndex + '"]').data('can-access-content-route')
      $.ajax(
        url: url,
        async: false,
        dataType: 'json'
      ).done( (data) ->
        if(!data.accessible)
          event.preventDefault()
          event.stopPropagation()
          activeslide.find(".alert-warning").removeClass("hidden")
      ).fail(->
        event.preventDefault()
        event.stopPropagation()
        activeslide.find(".alert-warning").removeClass("hidden")
      )

    sendContentProgress = (contentIndex) ->
      url = $('*[data-content-index="' + contentIndex + '"]').data('progress-content-route')
      if url
        $.ajax(
          url: url,
          type: 'PUT',
          dataType: 'json')

    prevContent = ->
      return currentContent() - 1 unless currentContent() == 1
      contentsCount()
    nextContent = ->
      return currentContent() + 1 unless currentContent() == contentsCount()
      1
    currentContent = ->
      $('#contents-carousel .item.active').data('content-index')

    contentsCount = ->
      $('#contents-carousel').data('contents-count')

    visibleContentsCount = ->
      $('#contents-carousel').data('visible-contents-count')

    isFirstContent = ->
      currentContent() == 1

    isLastContent = ->
      currentContent() == contentsCount()

    isLastVisibleContent = ->
      currentContent() == visibleContentsCount()

    $('a[data-can-access-unit-route]').click ->
      accessUnit($(this).data("can-access-unit-route"), $(this).attr('href'))

    $('a.rate-link').click ->
      canRate($(this).data("can-rate-route"))

    accessUnit = (can_access_url, unit_url) ->
      event.preventDefault()
      event.stopPropagation()
      $.ajax(
        url: can_access_url,
        async: true,
        dataType: 'json'
      ).done( (data) ->
        if data.accessible
          window.location.href = unit_url
        else
          $('#unit-error-modal').modal("show");
      ).fail(->
        activeslide.find(".alert-warning").removeClass("hidden")
      )

    updateProgress = ->
      url = $('#progress').data('progress-route')
      $.ajax(
        url: url,
        dataType: 'json'
      ).done( (data) ->
        if(data.progress)
          data.progress = data.progress + '%'
          $.each data.units, (unitIndex, progress) ->
            if unitIndex
              $("a[href$='#unit-" + unitIndex + "']").find('.dropdown-icons')
                .removeClass()
                .addClass('dropdown-icons')
                .addClass(progress)
          if $('#progress').attr('data-original-title') != '100%' &&
             data.progress == '100%' && !data.has_comments
              $('#user-comment-modal').modal('show');
          else
            $('.end_course').hide()
          $('#progress').width(data.progress)
          $('#progress').tooltip('hide')
          .attr('data-original-title', data.progress)
          .tooltip('fixTitle')
      )

    canRate = (url) ->
      $.ajax(
        url: url,
        dataType: 'json'
      ).done( (data) ->
        if(data.can_rate)
          event.preventDefault()
          event.stopPropagation()
          $('#user-comment-modal').modal("show");
        else
          $('#rate-error-modal .modal-body').html(data.message)
          $('#rate-error-modal').modal("show");
      ).fail(->
        event.preventDefault()
        event.stopPropagation()
        activeslide.find(".alert-warning").removeClass("hidden")
      )
