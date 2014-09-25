AutoForm.hooks null,
  beginSubmit: (formId, template) ->
    submitButton = template.find '[type=submit]'
    if submitButton then submitButton.button 'loading'
    return

  endSubmit: (formId, template) ->
    submitButton = template.find '[type=submit]'
    if submitButton then submitButton.button 'reset'
    return
