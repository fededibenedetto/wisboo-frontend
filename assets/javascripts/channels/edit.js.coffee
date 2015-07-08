load
  controllers:
    channels: []
, (controller, action) ->
  limitTextareaLines = (e) ->
    !(e.keyCode == 13 and $(this).val().split('\n').length >= $(this).attr('rows'))

  parseMetaKeywords = ->
    metaKeywords = $('.js-tag-input')
    return unless metaKeywords.length

    parsedMetaKeywords = metaKeywords.val()
    parsedMetaKeywords = parsedMetaKeywords.slice(1, -1).replace(/"/gi, '')
    metaKeywords.val(parsedMetaKeywords)

    metaKeywords.tagsinput()

  readURL = (input, img) ->
    if input.files && input.files[0]
      reader = new FileReader
      reader.onload = (e) ->
        img.attr 'src', e.target.result
        img.trigger('imageChanged')
      reader.readAsDataURL input.files[0]

  parseMetaKeywords()
  $('.make-bootstrap-switch').bootstrapSwitch()
  $('.tooltip-form a').tooltip()
  $('.js-limit-textarea-lines').keydown(limitTextareaLines)

  $('.js-file-input').click (e) ->
    e.preventDefault()
    $('#' + $(this).data('input-id')).click()

  $('.js-file-input').each ->
    $('#' + $(this).data('input-id')).change ->
      preview = $('.' + $(this).data('preview'))
      preview = $(this).siblings('.' + $(this).data('preview')) if preview.length > 1
      readURL this, preview
