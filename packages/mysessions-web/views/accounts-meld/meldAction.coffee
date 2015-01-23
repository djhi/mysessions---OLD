Template.meldAction.events
  'click #meldActionYes': (event, template) ->
    event.preventDefault()
    MeldActions.update {_id: @_id}, {$set: {meld: 'yes'}}
    return false

  'click #meldActionNotNow': (event, template) ->
    event.preventDefault()
    MeldActions.update {_id: @_id}, {$set: {meld: 'not_now'}}
    return false

  'click #meldActionNever': (event, template) ->
    event.preventDefault()
    MeldActions.update {_id: @_id}, {$set: {meld: 'never'}}
    return false
