@isLoggedIn = (userId) ->
  result = userId?
  console.log 'isLoggedIn: ' + result
  return result

@isNotLoggedIn = (userId) ->
  result = not userId?
  console.log 'isNotLoggedIn: ' + result
  return result
