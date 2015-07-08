jQuery ->
    setEducators = ->
      $('#course_educator_ids :hidden').show()
      main_ed = $("#course_main_educator_id").val()
      if main_ed
        $('#course_educator_ids option[value=' + main_ed + ']').hide().removeAttr("selected")

    changeChannel = ->
      channel = $('#course_channel_id :selected').text()
      channelId = parseInt($('#course_channel_id :selected').val())
      educator_options = $(educators).filter("optgroup[label='#{channel}']").html()
      user_options = $(users).filter("optgroup[label='#{channel}']").html()
      th_opt = $(thematics).filter("optgroup[label='#{channel}']").html()
      faq_opt = $(faqs).filter((index) ->
        channelsIds = $(this).data("channel-ids")
        $.inArray(channelId, channelsIds) != -1
      )
      $('.dinamic-input.educator').html(educator_options)
      $('.dinamic-input.user').html(user_options)
      $('#course_thematic_ids').html(th_opt)
      $('#course_faq_ids').html(faq_opt)
      unless $('#course_persisted').val() == 'true'
        $('#course_faq_ids option').prop('selected', true)
      setEducators()

    changePrivacy = ->
      $("#course_privacy_attributes_type > option").each ->
        # Hide no needed fields
        $('.' + $(this).val()).closest('li').toggle(this.selected)
        $('select.' + $(this).val()).val([]) if !this.selected

    educators = $('.dinamic-input.educator').html()
    users = $('.dinamic-input.user').html()
    thematics = $('#course_thematic_ids').html()
    faqs = $('#course_faq_ids').html()

    $(document).ready ->
      changeChannel()
      changePrivacy()

    $('#course_channel_id').change ->
      changeChannel()

    $('#course_main_educator_id').change ->
      setEducators()

    $('#course_privacy_attributes_type').change ->
      changePrivacy()
