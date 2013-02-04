
url = require('url')
module.exports =
  allowedPatterns: [
    /^\/analytics\/v2\.0\/service\/.*js$/
    /^\/slm\/webservice\/.*js$/
    /\/slm\/profile\/viewThumbnailImage.sp/
    /^\/apps.*/
  ]
  shouldForwardRequest : (req)->
    urlObject = url.parse(req.url)
    for pattern in module.exports.allowedPatterns
      if urlObject.pathname.match(pattern)
        return true
    return false