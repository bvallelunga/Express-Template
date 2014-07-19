module.exports = (ejs)->
   ejs.filters.capitalize = (str)->
      str.capitalize

   ejs.filters.empty = (array)->
      array.empty

   ejs.filters.random = (array)->
      array[Math.floor(Math.random() * array.length)]

   ejs.filters.urlencode = (str)->
      encodeURI str

   ejs.filters.link = (str, shorten)->
      str = str.replace "http://", ""
      str = str.replace "https://", ""

      unless shorten
         return str

      return "#{str.slice 0, shorten}#{if str.length >= shorten then '...' else ''}"
