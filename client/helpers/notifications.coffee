@Notifications =
  error: (message = TAPi18n.__("anErrorOccured")) ->
    $.growl message, type: 'danger', delay: 0
    return

  success: (message = TAPi18n.__("changesPersisted")) ->
    $.growl message, type: 'success'
    return
