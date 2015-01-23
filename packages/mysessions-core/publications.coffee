Collections = Collections

Meteor.publish "course", (id) ->
  return [
    # publish the course itself
    Courses.find _id:id
  ]

Meteor.publish "mycourses", ->
  return [
    Courses.find {userId: @userId}
  ]

Meteor.publish "participant", (id) ->
  return [
    Participants.find _id:id
  ]

Meteor.publish "sessions", (courseId) ->
  return [
    # publish all sessions for this course
    Sessions.find {courseId: courseId}, {sort: {date: -1}}
  ]

Meteor.publish "participants", (courseId, limit = 10) ->
  options =
    sort: name: 1
    limit: limit

  if courseId
    course = Courses.findOne courseId
    filter =
      _id: $in: course.participantsIds or []
      userId: @userId
  else
    filter = userId: @userId

  return [
    Participants.find filter, options
  ]

Meteor.publish "session", (id) ->
  return [
    Sessions.find _id:id
  ]

Meteor.publish "recipients", (courseId) ->
  return [
    # publish all recipients saved by this user
    ReportRecipients.find {userId: @userId}, {fields: {email: 1}, sort: {email: 1}}
  ]
