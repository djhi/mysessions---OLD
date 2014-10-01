@isLoggedIn = (userId) ->
  return userId?

@isNotLoggedIn = (userId) ->
  return not userId?
