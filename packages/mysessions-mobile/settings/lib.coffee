Settings =
  show: ->
    if not $(document.body).is('.action-sheet-open')
      IonActionSheet.show
        titleText: TAPi18n.__ 'settings'
        buttons: [
          text: TAPi18n.__ 'profile'
        ,
          text: TAPi18n.__ 'sign-out'
        ]

        buttonClicked: (index) ->
          if index == 0
            Router.go 'profile'

          if index == 1
            Meteor.logout()

          return true
