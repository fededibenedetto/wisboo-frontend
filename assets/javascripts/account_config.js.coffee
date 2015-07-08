$('#edit_user').bind "ajax:success", (e, data, status, xhr) ->
  if data.success
    clearInputs()
    $('#password-changed-alert').removeClass('hide')
    $('#change-password').modal('hide')
  else
    $.each(data.errors, (key, value) ->
      formGroup = $('#user_' + key).parent()
      formGroup.addClass('has-error')
      formGroup.find('.field-error').text(value).removeClass('hide')
    )

clearInputs = ->
  $('#edit_user').find('input[type="password"]').val('')

$('input[type="password"]').change(->
  formGroup = $(this).parent()
  formGroup.removeClass('has-error')
  formGroup.find('.field-error').addClass('hide')
)
