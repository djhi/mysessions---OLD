Migrations.add
  version: 2,
  up: ->
    participants = Participants.find()

    participants.forEach (participant) ->
      Courses.direct.update {_id: participant.courseId}, $addToSet: participantsIds: participant._id
      Participants.direct.update {_id: participant._id}, $unset: courseId: 1
