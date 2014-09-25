Template.editCourse.events
  'submit form': (event, template) ->
    event.preventDefault()
    courseForm = new ParseForm '#editCourseForm'
    courseData = _.pick courseForm, 'title', 'tags'

    course = template.data
    course.save courseData

    Router.go 'course', _id: course.id
    return false

Template.editCourse.rendered = ->
  @$('#editCourseForm').parsley trigger: 'change submit'
