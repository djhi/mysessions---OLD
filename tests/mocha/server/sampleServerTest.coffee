unless typeof MochaWeb is "undefined"
  MochaWeb.testOnly ->
    describe "Server initialization", ->
      it "should have a Meteor version defined", ->
        chai.assert Meteor.release
        return

      return

    return
