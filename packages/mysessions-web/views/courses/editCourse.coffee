AutoForm.addHooks 'editCourseForm',
  onSuccess: (operation, result, template) ->
    Router.go 'participants', _id: template.data.doc._id
    return
