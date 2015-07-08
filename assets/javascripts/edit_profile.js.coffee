load "users#account_config", ->
  $('.make-bootstrap-switch').bootstrapSwitch()
  $('[data-toggle="tooltip"]').tooltip()
load
  controllers:
    users: [
      "profile"
      "preferences"
    ]
, (controller, action) ->
    $("#user-tags-input").tokenInput $("#user-tags-input").data('tags-search'),
      queryParam: 'tag_name'
      theme: 'edit-profile-wisboo'
      placeHolderText: I18n.t('user.edit.preferences.learn_interested.token_input.thematics')
      preventDuplicates: true
      hintText: I18n.t('user.edit.preferences.learn_interested.token_input.pick_thematics')
      noResultsText: I18n.t('user.edit.preferences.learn_interested.token_input.no_results')
      searchingText: I18n.t('user.edit.preferences.learn_interested.token_input.searching')
      resultsLimit: 10
      prePopulate: $('#user-tags-input').data('start-tags')
      tokenValue: "name"
    updateThematicsInput = ->
      $('#user-thematics-input').val('')
      $(".learn-about > .tag").each ->
        if $(this).hasClass("active")
          $('#user-thematics-input').val($('#user-thematics-input').val() + $(this).text().trim() + ',')
    updateThematicsInput()
    $(".learn-about > .tag").click ->
      $(this).toggleClass("active")
      updateThematicsInput()
load
  controllers:
    users: [
      "profile"
      "edit_profile"
    ]
, (controller, action) ->
    $('.tooltip-form a').tooltip()
    $(".edit-profile form").change(->
      total = 0
      filled = 0
      $(".edit-profile [id^='user_']").each (index, element) ->
        total++
        filled++ if $(this).val()
        return
      $("#progress-menu").attr("aria-valuetransitiongoal", parseInt((filled / total) * 100))

      $('#form-progress').attr("data-original-title",  parseInt((filled / total) * 100) + "%");
      $('#form-progress').tooltip()

      $('#progress-menu').progressbar()
    ).trigger "change"

    $('#user_avatar').change ->
      $(this).toggleClass('user-avatar-input-empty', !$(this).val())

$(document).ready ->
  $("#form-progress").hover ->
    $(".tooltip").css "top", "-27px"
    $(".tooltip").css "left", "0"
    $(".tooltip").css "margin-top", "12px"
    $(".tooltip").css "margin-left", "100px"
    return
