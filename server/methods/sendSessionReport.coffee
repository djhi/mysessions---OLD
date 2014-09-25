Meteor.methods
  sendSessionReport: (sessionReport) ->
    if not Meteor.userId() then throw new Meteor.Error 401, 'Unauthorized', 'You aren\'t authorized to execute this function'

    check sessionReport.recipients, String
    check sessionReport.subject, String
    check sessionReport.body, String

    fromEmail = Meteor.user().emails[0].address

    # Let other method calls from the same client start running,
    # without waiting for the email sending to complete.
    @unblock()

    recipients = _.map sessionReport.recipients.split(','), (recipient) ->
      return _s.trim recipient
    
    Email.send
      to: recipients
      from: fromEmail
      subject: sessionReport.subject
      text: sessionReport.body
