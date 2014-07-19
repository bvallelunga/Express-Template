module.exports = (req, res, next)->
   # Set Server Root For Non Express Calls
   req.session.server = "#{req.protocol}://#{req.hostname}"

   if not config.general.production or not config.random
      config.random = Math.floor (Math.random() * 1000000) + 1

   # Header Config
   res.header 'Server', config.general.company
   res.header 'Access-Control-Allow-Credentials', true
   res.header 'Access-Control-Allow-Origin', req.hostname
   res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE'
   res.header 'Access-Control-Allow-Headers', 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Accept'

   #Locals
   res.locals.csrf = if req.csrfToken then req.csrfToken() else ""
   res.locals.production = config.general.production
   res.locals.host = req.session.server
   res.locals.title = ""
   res.locals.site_title = config.general.company
   res.locals.site_delimeter = config.general.delimeter
   res.locals.description = config.general.description.join ""
   res.locals.company = config.general.company
   res.locals.logo = config.general.logo
   res.locals.config = {}
   res.locals.icons = config.icons
   res.locals.user = req.session.user
   res.locals.title_first = true
   res.locals.random = "?rand=" + config.random
   res.locals.search = ""
   res.locals.logos =
     "logo" : "#{res.locals.host}/img/logo.png"
     "graph": "#{res.locals.host}/favicon/196.png"
     "1000" : "#{res.locals.host}/favicon/1000.png"
     "500"  : "#{res.locals.host}/favicon/500.png"
     "196"  : "#{res.locals.host}/favicon/196.png"
     "160"  : "#{res.locals.host}/favicon/160.png"
     "114"  : "#{res.locals.host}/favicon/114.png"
     "72"   : "#{res.locals.host}/favicon/72.png"
     "57"   : "#{res.locals.host}/favicon/57.png"
     "32"   : "#{res.locals.host}/favicon/32.png"

   # Redirect
   if "www" not in req.subdomains
      next()
   else
      res.redirect "#{req.protocol}://#{req.host.split(".").slice(1).join(".")}#{req.path}"
