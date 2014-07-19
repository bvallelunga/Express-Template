module.exports = ->
   # Return first item of an array
   Array::first = ->
     this[0]

   # Return last item of an array
   Array::last = ->
     this[this.length - 1]

   # Return if array is empty
   Array::empty = ->
     this.length is 0

   # Capitalize a string
   # string => String
   String::capitalize = ->
       this.replace /(?:^|\s)\S/g, (a) -> a.toUpperCase()

   # Classify a string
   # application_controller => ApplicationController
   String::classify = ->
     classified = []
     words = this.split('_')
     for word in words
       classified.push word.capitalize()

     classified.join('')
