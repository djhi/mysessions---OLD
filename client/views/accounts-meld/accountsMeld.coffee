Meteor.subscribe "pendingMeldActions"
MeldActions = new Meteor.Collection 'meldActions'

Template.accountsMeld.helpers
    completed: ->
        return MeldActions.find meld: "done"

    melding: ->
        return MeldActions.find meld: "melding"

    questions: ->
        return MeldActions.find meld: "ask"

    visible: ->
        return MeldActions.find().count() > 0
