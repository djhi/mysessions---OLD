AutoForm.addHooks 'newCourseForm',
  onSuccess: (operation, result, template) ->
    Router.go 'participants', _id: result
    return
