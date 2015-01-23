Template.layout.helpers
  textback: () ->
    return TAPi18n.__ 'back'

Template._submit.helpers
  label: () ->
    return TAPi18n.__ @label or 'save'

Template._cancel.helpers
  label: () ->
    return TAPi18n.__ @label or 'cancel'
