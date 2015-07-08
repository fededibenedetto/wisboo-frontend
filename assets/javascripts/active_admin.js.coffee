#= require active_admin/base
#= require selectize
#= require jquery.TableCSVExport
#= require admin_course

$(document).ready ->
  $('.selectize').selectize()

  $('a[data-export-table]').click (e) ->
    e.preventDefault()
    $("##{$(this).data('export-table')}").TableCSVExport()
