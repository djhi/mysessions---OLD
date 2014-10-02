Meteor.methods
  searchParticipantsByName: (query) ->
    cursor = Collections.Participants.find
      name: $regex: query, $options: 'i'
      userId: @userId

    return cursor.fetch()
