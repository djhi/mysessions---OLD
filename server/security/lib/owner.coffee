@isNotOwner = (userId, doc) ->
  result = doc.userId isnt userId
  console.log 'isNotOwner: ' + result
  return result

@isNotCourseOwner = (userId, sessionOrParticipant) ->
  courseId = sessionOrParticipant.courseId
  course = Collections.Courses.findOne courseId, fields: userId: 1

  result = course.userId isnt userId
  console.log 'isNotCourseOwner: ' + result
  return result
