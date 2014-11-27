Template.afInputDateWithMoment.rendered = Template.afInputDateWithMoment_bootstrap3.rendered = ->
  @$('input').datepicker
    viewMode: 'years'

  return


AutoForm.addInputType "moment",
  template: "afInputDateWithMoment"
  valueIn: (val) ->
    #convert Date to string value
    return moment(val).locale(i18n.getLanguageCode()).format('L')

  valueOut: ->
    val = @val()

    format = moment.localeData(i18n.getLanguageCode()).longDateFormat('L')

    m = moment(val, format, i18n.getLanguageCode())
    return m.toDate()

  valueConverters:
    string: (val) ->
      return (if (val instanceof Date) then AutoForm.Utility.dateToDateStringUTC(val) else val)

    stringArray: (val) ->
      return [AutoForm.Utility.dateToDateStringUTC(val)]  if val instanceof Date
      return val

    number: (val) ->
      return (if (val instanceof Date) then val.getTime() else val)

    numberArray: (val) ->
      return [val.getTime()]  if val instanceof Date
      return val

    dateArray: (val) ->
      return [val]  if val instanceof Date
      return val

  contextAdjust: (context) ->
    context.atts.max = AutoForm.Utility.dateToDateStringUTC(context.max)  if typeof context.atts.max is "undefined" and context.max instanceof Date
    context.atts.min = AutoForm.Utility.dateToDateStringUTC(context.min)  if typeof context.atts.min is "undefined" and context.min instanceof Date
    return context
