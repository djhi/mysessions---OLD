UI.registerHelper 'mdate', (date) ->
    return moment(date).format('L')

UI.registerHelper 'mdateform', (date) ->
    return moment(date).format('YYYY-MM-DD')

UI.registerHelper 'timeSpent', (duration, units = 'hours') ->
    if typeof duration isnt 'number'
      throw new Error('Invalid duration: not a number')

    return moment.duration(duration, units).humanize()

UI.registerHelper 'fromNow', (date) ->
  momentDate = moment(date)

  if not momentDate.isValid()
    throw new Error('Invalid date: not a Date nor a moment')

  return momentDate.fromNow()


UI.registerHelper 'formatDate', (date, format = 'DD/MM/YYYY') ->
  momentDate = moment(date)

  if not momentDate.isValid()
    throw new Error('Invalid date: not a Date nor a moment')

  return momentDate.format(format)


UI.registerHelper 'mediumDate', (date) ->
  momentDate = moment(date)

  if not momentDate.isValid()
    throw new Error('Invalid date: not a Date nor a moment')

  return momentDate.format('LL');

UI.registerHelper 'month', (date) ->
  momentDate = moment(date)

  if not momentDate.isValid()
    throw new Error('Invalid date: not a Date nor a moment')

  return momentDate.format('MMMM');

UI.registerHelper 'shortMonthAndYear', (date) ->
  momentDate = moment(date)

  if not momentDate.isValid()
    throw new Error('Invalid date: not a Date nor a moment')

  return momentDate.format('MMM YYYY');
