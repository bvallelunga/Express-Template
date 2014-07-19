# Import NPM Modules
express        = require "express"
slashes        = require "connect-slashes"
session        = require "express-session"
ejs            = require "ejs"
app            = express()
RedisStore     = require("connect-redis") session

# Import Local Modules
locals         = require "./routes/locals"
assets         = require "./assets"
routes         = require "./routes"

# Global Variables
GLOBAL.async   = require "async"
GLOBAL.config  = require "./config"
GLOBAL.lib     = require "./lib"

# Initialize Lib
lib.init.bind(lib, ejs)()

# HTML Engine
app.engine "html", ejs.renderFile

# Global Config
app.set "views", "views"
app.set "view engine", "html"
app.set "view options", layout: true
app.set "view cache", true
app.set "x-powered-by", false

# Piler Assests
assets.init app
app.use assets.express

# Direct Assests
app.use "/favicon", express.static "assets/favicons"
app.use "/fonts", express.static "assets/fonts"
app.use "/img", express.static "assets/images"

# External Addons
app.use slashes true

# Logger & Cookie
app.use session
   name: config.cookies.session.key
   secret: config.cookies.session.secret
   cookie: secure: true
   resave: false
   saveUninitialized: true
   store: new RedisStore

# Initialize Models
#app.use lib.models

# Setup Locals
app.use locals

# Activate Routes
routes app

# Start Listening to Port
app.listen config.general.port
