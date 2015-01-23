Template.sendSessionReport.rendered = ->
  options =
    maxItems: null
    valueField: 'email'
    labelField: 'label'
    searchField: 'email'
    sortField: [
      field: "type"
    ,
      field: "email"
    ]
    create: true
    persist: true
    hideSelected: true
    selectOnTab: true
    render:
      option_create: (data, escape) ->
        return '<div class="create">' + TAPi18n.__('add') + ' <strong>' + escape( data.input) + '</strong>&hellip;</div>'

  if Meteor.user().services.google
    options.preload = true
    options.load = (query, callback) ->
      Meteor.call 'getGoogleContacts', query, (error, contacts) ->
        results = ReportRecipients.find({}, sort: {email : 1}).map (recipient) ->
          return email: recipient.email, label: recipient.email, type: 0

        if error
          console.log error
          Notifications.error TAPi18n.__ 'googleContactsError'

        if contacts
          googleContacts = _.map contacts, (contact) ->
            return email: contact.email, label: 'Google: ' + contact.email, type: 1

          results = results.concat googleContacts

        callback results

        return
  else
    options.options = ReportRecipients.find({}, sort: {email : 1}).map (recipient) ->
      return email: recipient.email, label: recipient.email


  @$('[name=recipients]').selectize options

Template.sendSessionReport.helpers
  sessionReportSchema: ->
    schema = SessionReportSchema
    return schema

  recipients: ->
    return ReportRecipients.find {}, sort: {email : 1}

AutoForm.addHooks 'sessionReportForm',
  onSuccess: (operation, result, template) ->
    Notifications.success TAPi18n.__ 'reportSend'
