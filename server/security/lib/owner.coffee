@isNotOwner = (userId, doc) ->
  return doc.userId isnt userId

@isNotCourseOwner = (userId, sessionOrParticipant) ->
  courseId = sessionOrParticipant.courseId
  course = Collections.Courses.findOne courseId, fields: userId: 1

  return course.userId isnt userId
