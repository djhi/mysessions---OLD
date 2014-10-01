AccountsMeld.configure
  askBeforeMeld: true,
  meldDBCallback: (oldUserId, newUserId) ->
    Collections.Courses.direct.update {userId: oldUserId}, {$set: {userId: newUserId}}, {multi: true}
    Collections.Sessions.direct.update {userId: oldUserId}, {$set: {userId: newUserId}}, {multi: true}
    Collections.Participants.direct.update {userId: oldUserId}, {$set: {userId: newUserId}}, {multi: true}
    Collections.ReportRecipients.direct.update {userId: oldUserId}, {$set: {userId: newUserId}}, {multi: true}
