Future = Npm.require('fibers/future')
EventEmitter = Npm.require("events").EventEmitter
_ = Npm.require("underscore")
qs = Npm.require("querystring")
util = Npm.require("util")
url = Npm.require("url")
https = Npm.require("https")
querystring = Npm.require("querystring")

@GoogleContacts = (opts) ->
  opts = token: opts  if typeof opts is "string"
  opts = {}  unless opts
  @contacts = []
  @consumerKey = (if opts.consumerKey then opts.consumerKey else null)
  @consumerSecret = (if opts.consumerSecret then opts.consumerSecret else null)
  @token = (if opts.token then opts.token else null)
  @refreshToken = (if opts.refreshToken then opts.refreshToken else null)
  return

GoogleContacts:: = {}
util.inherits GoogleContacts, EventEmitter

GoogleContacts::_get = (params) ->
  url = 'https://www.google.com:443' + @_buildPath params
  options =
    headers:
      Authorization: "OAuth " + @token
      "GData-Version": "3.0"

  result = HTTP.get url, options
  return result.data

GoogleContacts::getContacts = (filter) ->
  self = this
  getContactsFuture = new Future

  handleResponse = (data) ->
    self._saveContactsFromFeed data.feed
    next = false
    data.feed.link.forEach (link) ->
      if link.rel is "next"
        next = true
        path = url.parse(link.href).path
        return handleResponse self._get path: path

    getContactsFuture.return self.contacts
    return

  handleResponse @_get type: "contacts", q: filter

  return getContactsFuture.wait()

GoogleContacts::_saveContactsFromFeed = (feed) ->
  self = this

  i = 0
  feed.entry.forEach (entry) ->
    try
      name = entry.title["$t"]
      email = entry["gd$email"][0].address # only save first email
      photoUrl = undefined
      mimeType = undefined
      entry.link.some (link) ->
        self.contacts.push
          email: email

    return

  return

GoogleContacts::_buildPath = (params) ->
  return params.path  if params.path
  params = params or {}
  params.type = params.type or "contacts"
  params.alt = params.alt or "json"
  params.projection = params.projection or "thin"
  params.email = params.email or "default"
  params["max-results"] = params["max-results"] or 2000
  query =
    alt: params.alt
    q: params.q
    "max-results": params["max-results"]

  path = "/m8/feeds/"
  path += params.type + "/"
  path += params.email + "/"
  path += params.projection
  path += "?" + qs.stringify(query)
  path

GoogleContacts::refreshAccessToken = (refreshToken) ->
  data =
    refresh_token: refreshToken
    client_id: @consumerKey
    client_secret: @consumerSecret
    grant_type: "refresh_token"

  console.log '------- Google data ------'
  console.log data

  body = qs.stringify(data)

  console.log '------- Google data ------'

  opts =
    host: "accounts.google.com"
    port: 443
    path: "/o/oauth2/token"
    method: "POST"
    headers:
      "Content-Type": "application/x-www-form-urlencoded"
      "GData-Version": "3.0"
      "Content-Length": body.length

  requestFuture = new Future

  req = https.request opts, (res) ->
    data = ""
    res.on "end", ->
      if res.statusCode < 200 or res.statusCode >= 300
        throw new Meteor.Error res.statusCode, 'Bad client request'
      try
        data = JSON.parse(data)
        requestFuture.return data.access_token
      catch err
        throw new Meteor.Error 503, 'Error while parsing response from Google API'

      return

    res.on "data", (chunk) ->
      data += chunk
      return

    res.on "error", (err) ->
      throw new Meteor.Error 503, 'Error while requesting Google API'

    return

  req.on "error", (err) ->
    throw new Meteor.Error 503, 'Error while requesting Google API'

  req.write body
  req.end()

  return requestFuture.wait()
