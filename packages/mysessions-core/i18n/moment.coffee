UI.registerHelper 'mDate', (date) ->
  # Calling this ensure this helper is re-evaluated whenever the current language changes
  i18n.getLanguage()
  return moment(date).format('L')

UI.registerHelper 'mDuration', (duration, units = 'hours') ->
  # Calling this ensure this helper is re-evaluated whenever the current language changes
  i18n.getLanguage()

  if typeof duration isnt 'number'
    throw new Error('Invalid duration: not a number')

  return moment.duration(duration, units).humanize()

UI.registerHelper 'mFromNow', (date, withoutSuffix = false) ->
  # Calling this ensure this helper is re-evaluated whenever the current language changes
  i18n.getLanguage()

  momentDate = moment(date)

  if not momentDate.isValid()
    throw new Error('Invalid date: not a Date nor a moment')

  return momentDate.fromNow(withoutSuffix)

UI.registerHelper 'mAge', (date) ->
  # Calling this ensure this helper is re-evaluated whenever the current language changes
  i18n.getLanguage()

  momentDate = moment(date)

  if not momentDate.isValid()
    throw new Error('Invalid date: not a Date nor a moment')

  return momentDate.add(1, 'years').fromNow(true)

UI.registerHelper 'mFormat', (date, format = 'DD/MM/YYYY') ->
  # Calling this ensure this helper is re-evaluated whenever the current language changes
  i18n.getLanguage()

  momentDate = moment(date)

  if not momentDate.isValid()
    throw new Error('Invalid date: not a Date nor a moment')

  return momentDate.format(format)

UI.registerHelper 'mMonth', (date) ->
  # Calling this ensure this helper is re-evaluated whenever the current language changes
  i18n.getLanguage()

  momentDate = moment(date)

  if not momentDate.isValid()
    throw new Error('Invalid date: not a Date nor a moment')

  return momentDate.format('MMMM');
