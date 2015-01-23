Template.newParticipantFromExisting.events
  'submit #existingParticipantsForm': (event, template) ->
    event.preventDefault()
    previousRoute = Session.get 'previousRoute'

    selectize = template.find('[name=participantsIds]').selectize

    participantsIds = selectize.getValue()

    if participantsIds instanceOf Array
      Courses.update template.data.course._id, $addToSet: participantsIds: $each: participantsIds
    else
      Courses.update template.data.course._id, $addToSet: participantsIds: participantsIds

    if previousRoute
      Router.go previousRoute
    else
      Router.go 'participants', _id: template.data.course._id

    return false

Template.newParticipantFromExisting.rendered = ->
  @$('[name=participantsIds]').selectize
      maxItems: null
      valueField: '_id'
      labelField: 'name'
      searchField: 'name'
      sortField: 'name'
      create: false
      persist: true
      hideSelected: true
      selectOnTab: true
      load: (query, callback) ->
        Meteor.call 'searchParticipantsByName', query, (error, participants) ->
          callback participants
          return

  return
