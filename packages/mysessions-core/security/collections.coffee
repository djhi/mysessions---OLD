Meteor.startup ->
  # Courses
  # ----------------------------------------------------------------------------
  Courses.allow
    insert: isLoggedIn
    update: isLoggedIn
    remove: isLoggedIn

  Courses.deny
    update: isNotOwner
    remove: isNotOwner

  # Sessions
  # ----------------------------------------------------------------------------
  Sessions.allow
    insert: isLoggedIn
    update: isLoggedIn
    remove: isLoggedIn

  Sessions.deny
    update: isNotOwner
    remove: isNotOwner

  Sessions.deny
    update: isNotCourseOwner
    remove: isNotCourseOwner

  # Participants
  # ----------------------------------------------------------------------------
  Participants.allow
    insert: isLoggedIn
    update: isLoggedIn
    remove: isLoggedIn

  Participants.deny
    update: isNotOwner
    remove: isNotOwner
