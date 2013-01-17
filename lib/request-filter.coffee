
url = require('url')
module.exports =
  shouldForwardRequest : (req)->
    urlObject = url.parse(req.url)
    allowedPatterns = [
      /^\/analytics\/v2\.0\/service\/.*js$/
      /^\/slm\/webservice\/.*js$/
      /\/slm\/profile\/viewThumbnailImage.sp/
      /^\/apps.*/
    ]
    for pattern in allowedPatterns
      if urlObject.pathname.match(pattern)
        return true
    return false