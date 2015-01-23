AutoForm.addHooks null,
  beginSubmit: (formId, template) ->
    submitButton = template.$ '[type=submit]'
    if submitButton then submitButton.button 'loading'
    return

  endSubmit: (formId, template) ->
    submitButton = template.$ '[type=submit]'
    if submitButton then submitButton.button 'reset'
    return

  onSuccess: (operation, result, formId) ->
    Notifications.success()
    return

  onError: (operation, error, formId) ->
    console.log error
    Notifications.error()
    return
###
  'input.selectized': ->
    value = this.val()

    if value and value.length > 0 then return value.split ','
    return []
###
