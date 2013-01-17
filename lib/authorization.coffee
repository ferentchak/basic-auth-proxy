module.exports =({username,password})->
  auth = "Basic " + new Buffer("#{username}:#{password}").toString("base64")
  return{
    decodeAuthorization : (authorization)=>
      decoded =  new Buffer(authorization, 'base64').toString('ascii')
      [name, password] = decoded.split(":")
      return {name, password}
    addAuthTokenToHeader:(header)=>
      header = header||{}
      header.Authorization= auth
      return header
  }