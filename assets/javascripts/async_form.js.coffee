$(document).ready ->
  loadModalRegisterForm()

loadModalRegisterForm = ->
  unless $(document.body).data('user')
    loadModalView
      url: '/users/sign_in'
      formSelector: '#modal-form'
      show: $('#modal-form').data('show-login') and not ($(location).attr('hash') == '#reset-password')
    if $(location).attr('hash') == '#reset-password'
      loadModalView
          url: '/users/password/edit?reset_password_token=' + getUrlParameter('reset_password_token')
          formSelector: '#modal-form-reset-password'
          show: true

loadModalView = (options) ->
  options = $.extend({
      url: '/users/sign_in',
      show: false,
      formSelector: '#modal-form'
    }, options || {})
  $.ajax(url: options.url)
  .done (html) ->
    $(options.formSelector + ' .modal-content').html html
    asyncModalForm()
    asyncModalUrl()
    if options.show
      $(options.formSelector).modal('show')

asyncModalUrl = ->
  $('.async-modal-url').on 'ajax:success', (e, data, status, xhr) ->
    $('#modal-form .modal-content').html data
    asyncModalUrl()
    asyncModalForm()

asyncModalForm = ->
  $('.async-modal-form').on('ajax:success', (e, data, status, xhr) ->
    clearMessages()
    if data.success
      if data.message
        showMessage(data.message)
        $('.async-modal-form input.btn').prop('disabled', true)
      else
        if data.path
          location.assign(data.path)
        else
          location.reload(true)
    else
      loadFormErrors(data.errors)
  ).on 'ajax:error', (e, data, status, xhr) ->
    clearMessages()
    $('.async-modal-form .errors').html data.responseText
    asyncModalUrl()
    asyncModalForm()
  # Modal view, renders the modal again
  $('.async-modal-view').on('ajax:success', (e, data, status, xhr) ->
    if data.success
      location.reload(true)
    else
      $(this).closest('.modal-content').html data
      asyncModalUrl()
      asyncModalForm()
  ).on 'ajax:error', (e, data, status, xhr) ->
    $(this).closest('.modal-content').html data
    asyncModalUrl()
    asyncModalForm()

showMessage = (message) ->
  list = '<ul class="list-unstyled">'
  list += '<li>' + message + '</li>'
  list += '</ul>'
  $('.async-modal-form .success').html list


loadFormErrors = (errors) ->
  list = '<ul class="list-unstyled">'

  for a of errors
    list += '<li>' + capitaliseFirstLetter(a) + ' ' + errors[a] + '</li>'

  list += '</ul>'

  $('.async-modal-form .errors').html list

capitaliseFirstLetter = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1)

clearMessages = ->
  $('.async-modal-form .success').empty()
  $('.async-modal-form .errors').empty()

getUrlParameter = (sParam) ->
  sPageURL = window.location.search.substring(1)
  sURLVariables = sPageURL.split("&")
  i = 0

  while i < sURLVariables.length
    sParameterName = sURLVariables[i].split("=")
    return sParameterName[1]  if sParameterName[0] is sParam
    i++
