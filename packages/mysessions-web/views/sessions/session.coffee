Template.session.events
  'click .btn-remove': (event, template) ->
    event.preventDefault()

    AntiModals.confirm
      message: TAPi18n.__ 'confirmRemove'
      cancel: TAPi18n.__ 'cancel'
      ok: TAPi18n.__ 'remove'
    ,
      (error, confirmed) ->
        if confirmed
          Sessions.remove template.data._id, (error) ->
            if error
              Notifications.error()
              return
            else
              Notifications.success()

    return false
