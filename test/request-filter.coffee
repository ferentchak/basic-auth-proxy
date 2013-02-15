assert = require 'assert'
fs = require('fs')
path = require("path");
currentDirectory = process.cwd();
configFileLocation = path.join(currentDirectory, "config.json");
{directProxyPatterns} = JSON.parse(fs.readFileSync(configFileLocation))
{shouldForwardRequest} = require "../lib/request-filter.coffee"


describe('RequestFilter', ()->

  mockRequest = ({url})->
    {url}

  describe('allows valid requests', ()->
    it('should allow requests for the SDK', ()->
      url = "https://rally1.rallydev.com/apps/2.0p4/sdk.js"
      request = mockRequest({url})
      assert(shouldForwardRequest(request,directProxyPatterns))
    )

    it('should allow requests to the LBAPI', ()->
      url = "https://rally1.rallydev.com/analytics/v2.0/service/rally/workspace/41529001/artifact/snapshot/query.js?find={Project:279050021,ScheduleState:{$lt:%22Accepted%22,$gte:%22In-Progress%22}}"
      request = mockRequest({url})
      assert(shouldForwardRequest(request,directProxyPatterns))
    )

    it('should allow requests to the WSAPI', ()->
      url = "https://rally1.rallydev.com/slm/webservice/x/hierarchicalrequirement/41573704.js"
      request = mockRequest({url})
      assert(shouldForwardRequest(request,directProxyPatterns))
    )
  )

  describe('rejects invalid requests', ()->
    it('should reject the login page', ()->
      url = "https://rally1.rallydev.com/slm/login.op?logout=true"
      request = mockRequest({url})
      assert(!shouldForwardRequest(request,directProxyPatterns))
    )

    it('should reject html pages', ()->
      url = "https://rally1.rallydev.com/pandas.html"
      request = mockRequest({url})
      assert(!shouldForwardRequest(request,directProxyPatterns))
    )

    it('should reject xml', ()->
      url = "https://rally1.rallydev.com/slm/webservice/x/hierarchicalrequirement/41573704.xml"
      request = mockRequest({url})
      assert(!shouldForwardRequest(request,directProxyPatterns))
    )
  )
)