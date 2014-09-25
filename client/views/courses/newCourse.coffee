AutoForm.addHooks 'newCourseForm',
  onSuccess: (operation, result, template) ->
    Router.go 'course', _id: result
    return
