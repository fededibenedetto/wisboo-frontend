load
  controllers:
    channels: ['contents']
, (controller, action) ->
  updateIdText = (id, text) ->
    $(".js-content-media-#{id}").html(text)
  updateMediaId = (uploader, media_id) ->
    $.ajax
      url: uploader.data('content-url')
      type: 'PUT'
      data:
        wistia_id: media_id
      success: (result) ->
        updateIdText(uploader.data('content-id'), result.media_id)
      error: (error) ->
        updateIdText(uploader.data('content-id'), uploader.data('uploading-error'))
  $('.js-wistia-uploader').each (index) ->
    courseId = $(this).data('course-id')
    $(this).fileupload
      dataType: 'json'
      send: ->
        updateIdText($(this).data('content-id'), $(this).data('uploading-text'))
      done: (e, data) ->
        content = data.result
        updateMediaId($(this), content.hashed_id)
