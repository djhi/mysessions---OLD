Collections = @Collections

Meteor.publish "course", (id) ->
  return [
    # publish the course itself
    Collections.Courses.find _id:id
  ]

Meteor.publish "mycourses", ->
  return [
    Collections.Courses.find {userId: @userId}, {fields: title: 1, participantsCount: 1, lastSession: 1}
  ]

Meteor.publish "participant", (id) ->
  return [
    Collections.Participants.find _id:id
  ]

Meteor.publish "sessions", (courseId) ->
  return [
    # publish all sessions for this course
    Collections.Sessions.find {courseId: courseId}, {sort: {date: -1}}
  ]

Meteor.publish "participants", (courseId) ->
  return [
    # publish all participants for this course
    Collections.Participants.find {courseId: courseId}, {sort: name: 1}
  ]

Meteor.publish "session", (id) ->
  return [
    Collections.Sessions.find _id:id
  ]

Meteor.publish "recipients", (courseId) ->
  return [
    # publish all recipients saved by this user
    Collections.ReportRecipients.find {userId: @userId}, {fields: {email: 1}, sort: {email: 1}}
  ]
