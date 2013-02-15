http = require('http')
https = require('https')
request = require('request')
{parse} = require('url')
_ = require('underscore')

addAuth = (username,password)->
  if !(username && username.length)
    return false
  if !(password && password.length)
    return false
  return true
module.exports = ({username,password,targetServer,proxyPort,directProxyPatterns})->
  {shouldForwardRequest}= require("./request-filter")
  proxyPort = proxyPort||9001
  http.createServer((req, res)->
    if addAuth(username,password)
      {addAuthTokenToHeader} = require("./authorization")({username,password})
      headers = addAuthTokenToHeader()
    urlObject = parse(req.url)
    if(shouldForwardRequest(req,directProxyPatterns))
      url = "#{targetServer}#{urlObject.path}"
      request(
        {headers,url}
        (error, response, body) ->
          if (!error)
            res.writeHead(response.statusCode, response.headers)
            res.write(body)
            res.end()
          else
            console.log error,response.statusCode
      )
    else
      console.log "Filtered #{req.url}"
      res.writeHead(400, { 'Content-Type': 'text/json' })
      res.write(JSON.stringify({errors:["Request Filtered by proxy"]}))
      res.end()
  ).listen(proxyPort)



