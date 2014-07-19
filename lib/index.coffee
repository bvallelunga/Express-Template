module.exports =
   core     : require './core'
   models   : require './models'
   init     : (ejs)->
      @core.helpers()
      @core.filters ejs
