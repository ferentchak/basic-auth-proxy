http = require('http')
https = require('https')
request = require('request')
{parse} = require('url')
_ = require('underscore')


module.exports = ({username,password,targetServer,proxyPort})->
  {addAuthTokenToHeader} = require("./authorization")({username,password})
  {shouldForwardRequest}= require("./request-filter")
  proxyPort = proxyPort||9001
  http.createServer((req, res)->
    headers = addAuthTokenToHeader()
    urlObject = parse(req.url)
    if(shouldForwardRequest(req))
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
      res.writeHead(400, { 'Content-Type': 'text/json' })
      res.write(JSON.stringify({errors:["Request Filtered by proxy"]}))
      res.end()
  ).listen(proxyPort)



