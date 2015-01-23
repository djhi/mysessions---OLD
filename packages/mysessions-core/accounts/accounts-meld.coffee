AccountsMeld.configure
  askBeforeMeld: true,
  meldDBCallback: (oldUserId, newUserId) ->
    Courses.direct.update {userId: oldUserId}, {$set: {userId: newUserId}}, {multi: true}
    Sessions.direct.update {userId: oldUserId}, {$set: {userId: newUserId}}, {multi: true}
    Participants.direct.update {userId: oldUserId}, {$set: {userId: newUserId}}, {multi: true}
    ReportRecipients.direct.update {userId: oldUserId}, {$set: {userId: newUserId}}, {multi: true}
