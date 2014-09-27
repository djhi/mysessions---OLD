AutoForm.hooks null,
  beginSubmit: (formId, template) ->
    submitButton = template.find '[type=submit]'
    if submitButton then submitButton.button 'loading'
    return

  endSubmit: (formId, template) ->
    submitButton = template.find '[type=submit]'
    if submitButton then submitButton.button 'reset'
    return

  onSuccess: (operation, result, formId) ->
    Notifications.success '', TAPi18n.__ "changesPersisted", timeout: 5000
    return

  onError: (operation, error, formId) ->
    console.log error
    Notifications.error '', TAPi18n.__ "anErrorOccured"
    return

AutoForm.inputValueHandlers
  'input.datepicker': ->
    selectedMoment = this.datepicker 'get'

    if moment.isMoment selectedMoment then return selectedMoment.toDate()
    return ''
