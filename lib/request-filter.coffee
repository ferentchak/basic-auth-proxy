
url = require('url')
module.exports =
  shouldForwardRequest : (req,patterns)->
    urlObject = url.parse(req.url)
    for pattern in patterns
      if urlObject.pathname.match(pattern)
        return true
    return false