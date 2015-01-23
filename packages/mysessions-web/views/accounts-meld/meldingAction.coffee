Template.meldingAction.events
  'click #closeButton': (event, template) ->
    event.preventDefault()
    MeldActions.update {_id: this._id}, {$set: {meld: 'ok'}}
    return false
