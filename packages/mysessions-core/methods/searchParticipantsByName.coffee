Meteor.methods
  searchParticipantsByName: (query) ->
    cursor = Participants.find
      name: $regex: query, $options: 'i'
      userId: @userId

    return cursor.fetch()
