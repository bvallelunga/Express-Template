module.exports =
   core : require './core'
   init : (ejs)->
      @core.helpers()
      @core.filters ejs
