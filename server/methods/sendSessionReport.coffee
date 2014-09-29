Meteor.methods
  sendSessionReport: (sessionReport) ->
    if not Meteor.userId() then throw new Meteor.Error 401, 'Unauthorized', 'You aren\'t authorized to execute this function'

    check sessionReport.recipients, [String]
    check sessionReport.subject, String
    check sessionReport.body, String

    fromEmail = Meteor.user().emails[0].address

    # Let other method calls from the same client start running,
    # without waiting for the email sending to complete.
    @unblock()

    ###
    recipients = _.map sessionReport.recipients.split(','), (recipient) ->
      return _s.trim recipient
    ###

    # Save recipients for futur use
    _.each sessionReport.recipients, (recipient) ->
      Collections.ReportRecipients.upsert
        email: recipient
      ,
        $set: email: recipient

    # Send the report
    Email.send
      to: sessionReport.recipients
      from: fromEmail
      replyTo: fromEmail
      subject: sessionReport.subject
      text: sessionReport.body
