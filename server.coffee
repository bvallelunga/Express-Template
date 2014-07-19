# Import NPM Modules
express        = require "express"
device         = require "express-device"
slashes        = require "connect-slashes"
ejs            = require "ejs"
app            = express()
srv            = require('http').createServer app
RedisStore     = require("connect-redis") express

# Global Variables
GLOBAL.async   = require "async"
GLOBAL.config  = require "./config"
GLOBAL.lib     = require "./lib"

# Initialize Lib
lib.init ejs

app.configure ->
   # HTML Engine
   app.engine "html", ejs.renderFile

   # Global Config
   app.set "views", "views"
   app.set "view engine", "html"
   app.set "view options", layout: true
   app.set "view cache", true
   app.set "x-powered-by", false

   # Piler Assests
   app.use require("./public") app, srv

   # Direct Assests
   app.use "/favicon", express.static "public/favicons"
   app.use "/fonts", express.static "/public/fonts"
   app.use "/img", express.static "/public/images"

   # External Addons
   app.use slashes true
   app.use device.capture()


   # Logger & Cookie
   app.use express.logger "dev"
   app.use express.compress()
   app.use express.bodyParser()
   app.use express.methodOverride()
   app.use express.cookieParser config.cookies.session.secret
   app.use express.session
      key: config.cookies.session.key
      secret: config.cookies.session.secret
      store: new RedisStore client: lib.redis

   # Initialize Models
   app.use lib.models

   # Setup Globals
   app.use require "./routes/globals"

# Production Only
app.configure 'production', ->
   # Last Resort Error Handling
   process.on 'uncaughtException', (exception)->
     return console.error exception

# Activate Routes
require("./routes") app

# Start Router
app.use app.router
srv.listen config.general.port
