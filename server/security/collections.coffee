Meteor.startup ->
  # Courses
  # ----------------------------------------------------------------------------
  @Collections.Courses.allow
    insert: isLoggedIn
    update: isLoggedIn
    remove: isLoggedIn

  @Collections.Courses.deny
    update: isNotOwner
    remove: isNotOwner

  # Sessions
  # ----------------------------------------------------------------------------
  @Collections.Sessions.allow
    insert: isLoggedIn
    update: isLoggedIn
    remove: isLoggedIn

  @Collections.Sessions.deny
    update: isNotOwner
    remove: isNotOwner

  @Collections.Sessions.deny
    update: isNotCourseOwner
    remove: isNotCourseOwner

  # Participants
  # ----------------------------------------------------------------------------
  @Collections.Participants.allow
    insert: isLoggedIn
    update: isLoggedIn
    remove: isLoggedIn

  @Collections.Participants.deny
    update: isNotOwner
    remove: isNotOwner
