# Import NPM Modules
express        = require "express"
slashes        = require "connect-slashes"
session        = require "express-session"
ejs            = require "ejs"
bodyParser     = require "body-parser"
app            = express()
srv            = require("http").createServer(app);
RedisStore     = require("connect-redis") session

# Import Local Modules
routes         = require "./routes"
locals         = require "./routes/locals"
assets         = require "./assets"

# Global Variables
GLOBAL.async   = require "async"
GLOBAL.config  = require "./config"
GLOBAL.lib     = require "./lib"

# Initialize Lib
lib.init.bind(lib, ejs)()

# HTML Engine
app.engine "html", ejs.renderFile

# Express Config
app.set "views", "#{__dirname}/views"
app.set "view engine", "html"
app.set "view options", layout: true
app.set "view cache", true
app.set "x-powered-by", false

# Express Settings
app.use require('compression')()
app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()

# Piler Assests
assets.init app, srv
app.use assets.express

# Direct Assests
app.use "/favicon", express.static "#{__dirname}/assets/favicons"
app.use "/fonts", express.static "#{__dirname}/assets/fonts"
app.use "/img", express.static "#{__dirname}/assets/images"

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
app.use lib.models

# Setup Locals
app.use locals

# Activate Routes
routes app

# Start Listening to Port
srv.listen config.general.port
