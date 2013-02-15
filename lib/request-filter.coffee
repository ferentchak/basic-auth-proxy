
url = require('url')
module.exports =
  allowedPatterns: []
  shouldForwardRequest : (req)->
    urlObject = url.parse(req.url)
    for pattern in module.exports.allowedPatterns
      if urlObject.pathname.match(pattern)
        return true
    return false