Migrations.add
  version: 2,
  up: ->
    participants = Collections.Participants.find()

    participants.forEach (participant) ->
      Collections.Courses.direct.update {_id: participant.courseId}, $addToSet: participantsIds: participant._id
      Collections.Participants.direct.update {_id: participant._id}, $unset: courseId: 1
