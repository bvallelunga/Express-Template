# Import NPM Module
piler = require "piler"
fs    = require "fs"

# Initialize Piler
pilers =
   coffee : piler.createJSManager urlRoot: "coffee"
   less   : piler.createCSSManager urlRoot: "less"

module.exports = (app, srv)->
    for piler, type in pilers
      piler.bind app, srv

      for directory in fs.readdirSync type
         path = "#{type}/#{directory}"

         if fs.statSync(path).isDirectory()
            for file in fs.readdirSync path
               filePath = "#{path}/#{file}"

               if directory is "global"
                  directory = null

               if file is "external.txt"
                  for link in fs.readFileSync(filePath, "utf-8").split "\n"
                     piler[type].addUrl directory, link
               else
                  piler[type].addFile directory, filePath

   return (req, res, next)->
      req.cofefee = pilers.coffee;
      req.less = pilers.less;
      next();
