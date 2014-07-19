module.exports = (app)->
   require("./routes") (routes)->
      async.each routes, (route, next)->
         if route.route
            route.route app, routes
         next()
      , -> app.all "*", routes.error
