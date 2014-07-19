# Import NPM Module
piler = require "piler"
fs    = require "fs"

# Initialize Piler
pilers =
   coffee : piler.createJSManager urlRoot: "coffee"
   less   : piler.createCSSManager urlRoot: "less"

module.exports.init = (app)->
    for piler, type in pilers
      piler.bind app

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

module.exports.express = (req, res, next)->
   req.coffee = pilers.coffee;
   req.less = pilers.less;
   next();
