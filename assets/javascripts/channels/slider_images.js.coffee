load
  controllers:
    channels: []
, (controller, action) ->
  sliderUrl = $('.js-add-slider-image')

  showErrorAlert = (type) ->
    message = $('.js-slider-error').data(type)
    $('.js-slider-error-message').html(message)
    $('.js-slider-error').removeClass('hide')

  hideErrorAlert = ->
    $('.js-slider-error').addClass('hide')

  disableButton = (button) ->
    button.attr('disabled','disabled')
    button.html(button.data('uploading-text'))

  enableButton = (button) ->
    button.attr('disabled', null)
    button.html(button.data('original'))

  readURL = (input, img) ->
    return unless input.files && input.files[0]
    reader = new FileReader
    reader.onload = (e) ->
      img.attr 'src', e.target.result
      img.trigger('imageChanged')
    reader.readAsDataURL input.files[0]

  updateBinds = (imageId) ->
    $('.js-slider-edit-image').unbind()
    $('.js-slider-image-delete').unbind()

    $('.js-slider-edit-image').on 'imageChanged', ->
      editSliderImage($(this).closest('.js-slider-image-show'))
    $('.js-slider-image-delete').on 'click', (e) ->
      e.preventDefault()
      deleteSliderImage($(this).closest('.js-slider-image-show'))

    return unless imageId

    $(".js-slider-image-button-#{imageId}").click (e) ->
      e.preventDefault()
      $("#slider_file_#{imageId}").click()
    $("#slider_file_#{imageId}").change ->
      preview = $('.' + $(this).data('preview'))
      preview = $(this).siblings('.' + $(this).data('preview')) if preview.length > 1
      readURL this, preview

  newSliderImage = ->
    postUrl = $('.js-add-slider-image').data('url')
    sliderFile = $('.js-slider-image-preview').attr('src')
    button = $('.new-slider-image-text')

    button.html(button.data('uploading'))
    $.post(postUrl, { channel_image: { image: sliderFile } } , (data) ->
      $('.js-slider-images').append(data)
      imageId = $('.js-slider-images').children('.js-slider-image-show').last().data('id')
      updateBinds(imageId)
    ).fail((data) ->
      showErrorAlert('image')
    ).always(->
      button.html(button.data('original'))
    )

  editSliderImage = (form) ->
    imageId = form.data('id')

    showButton = $(".js-slider-image-button-#{imageId}")
    disableButton(showButton)

    sliderFile = $(".js-slider-image-preview-#{imageId}").attr('src')
    url = form.data('url')

    $.ajax(
      type: 'PUT'
      url: url
      data:
        channel_image:
          image: sliderFile
      dataType: 'json')
      .fail ->
        showErrorAlert('image')
      .always ->
        enableButton(showButton)

  deleteSliderImage = (form) ->
    imageId = form.data('id')
    url = form.data('url')

    $.ajax
      type: 'DELETE'
      url: url
      dataType: 'json'
      success: (data) ->
        form.remove()
      error: (data) ->
        showErrorAlert('delete')

  updateBinds()

  $('.js-add-slider-image').click (e) ->
    e.preventDefault()
  $('.js-slider-new-image').on 'imageChanged', ->
    newSliderImage()

  $('.js-close-slider-error').click ->
    hideErrorAlert()
