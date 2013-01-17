#assert = require 'assert'
#{username,password,url} = require "./auth.json"
#authorization = require("../lib/authorization.coffee")({username,password})
#request = require('request')
#describe 'Authorization', ()->
#
#  describe 'allows valid requests', ()->
#    it 'should allow requests to auth requiring url', (done)->
#      options = {url}
#      options.headers = authorization.addAuthTokenToHeader {}
#      request options,(error, response)=>
#        assert.strictEqual(response.statusCode,200)
#        done(error)
