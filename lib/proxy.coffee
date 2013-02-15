http = require('http')
https = require('https')
request = require('request')
{parse} = require('url')
_ = require('underscore')

addCORSHeaders = (header)->
  header["Access-Control-Allow-Origin"]="*"
  header["Access-Control-Allow-Headers"]="X-Requested-With"
  return header



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
    if req.method == "OPTIONS"
      res.writeHead(200, addCORSHeaders({}))
      res.write("{}")
      res.end()
      return
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
            addCORSHeaders(response.headers)
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



