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
          Collections.Sessions.remove template.data._id, (error) ->
            if error
              Notifications.error '', TAPi18n.__ 'anErrorOccured'
              return
            else
              Notifications.success '', TAPi18n.__ 'changesPersisted', 5000

    return false
