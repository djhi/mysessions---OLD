Template.sendSessionReport.rendered = ->
  @$('[name=recipients]').selectize
    maxItems: null,
    valueField: 'email',
    labelField: 'email',
    searchField: 'email',
    options: Collections.ReportRecipients.find({}, sort: {email : 1}).fetch()
    create: true
    persist: true
    hideSelected: true
    selectOnTab: true
    render:
      option_create: (data, escape) ->
        return '<div class="create">' + TAPi18n.__('add') + ' <strong>' + escape( data.input) + '</strong>&hellip;</div>'

Template.sendSessionReport.helpers
  sessionReportSchema: ->
    schema = Schemas.SessionReport
    return schema

  sendLabel: ->
    return TAPi18n.__ "send"

  recipients: ->
    return Collections.ReportRecipients.find {}, sort: {email : 1}

AutoForm.addHooks 'sessionReportForm',
  onSuccess: (operation, result, template) ->
    Notifications.success '', TAPi18n.__ 'reportSend'
