#
# W E C H A T . J S
#
# (C) 2017 ERICLONG
# THIS PROJECT IS PROTECTED BY THE MIT LICENSE. SEE "LICENSE" FOR MORE DETAIL.
#

async   = require "async"
request = require "request"
cheerio = require "cheerio"
open    = require "open"

hosts = require("./hosts")

formatParams = (params) ->
  result = "?"
  for k, v of params
    result += "#{k}=#{v}&"
  return result.substr 0, result.length - 1

class WeChat
  constructor: (args) ->
    @appid    = "wx782c26e4c19acffb"
    @uuid     = ""
    @skey     = ""
    @sid      = ""
    @uin      = ""
    @ticket   = ""
    @deviceID = "e" + Math.random().toString()[2..16]
    @syncKey  = {}
    @user     = {}
    @contact  = {}
    @login()

  login: ->
    async.waterfall [
      (callback) =>
        @getUUID callback
      (callback) =>
        @showQRCode callback
      (callback) =>
        @waitForLogin callback
    ], (err, result) =>
      if err then throw err
  getUUID: (callback) ->
    params = formatParams
      appid: @appid
      fun:   "new"
      lang:  "zh_CN"
      _:     Date.now()
    url = hosts.login.getUUID + params
    request.get url, (err, res, body) =>
      if err then return callback err
      console.log body
      code = body
        .match(/window\.QRLogin\.code = \d+?;/)[0]
        .match(/\d+/)[0]
      if code isnt "200"
        return callback new Error "Error when getting UUID, code #{code}"
      @uuid = body
        .match(/window\.QRLogin\.uuid = ".+?";/)[0]
        .match(/".+"/)[0]
        .replace(/"/g, "")
      callback null
  showQRCode: (callback) ->
    open hosts.login.showQRCode + @uuid
    callback null
  waitForLogin: (callback, tip = 1) ->
    params = formatParams
      tip:  tip
      uuid: @uuid
      _:    Date.now()
    url = hosts.login.waitForLogin + params
    request.get url, (err, res, body) =>
      if err then return callback err
      code = body
        .match(/window\.code=\d+?;/)[0]
        .match(/\d+/)[0]
      switch code
        when "408" then @waitForLogin callback
        when "201" then @waitForLogin callback, 0
        when "200"
          redirect = body
            .match(/window\.redirect_uri=".+?";/)[0]
            .match(/".+"/)[0]
            .replace(/"/g, "")
          @getCookie redirect, callback
        else return callback new Error "Error when waiting for login, code #{code}"
  getCookie: (redirect, callback) ->
    url = redirect + "&fun=new"
    console.log callback
    request.get url, (err, res, body) =>
      if err then return callback err
      $ = cheerio.load body
      code = $("ret").text()
      if code isnt "0"
        return callback new Error "Error when getting cookie, code #{code}"
      @skey   = $("skey").text()
      @sid    = $("wxsid").text()
      @uin    = $("wxuin").text()
      @ticket = $("pass_ticket").text()
      console.log @skey, @sid, @uin, @ticket
      callback null

(new WeChat)
