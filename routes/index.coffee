module.exports = (app)->
   require("./routes") (routes)->
      for route in routes
         if route.route
            route.route app, routes

      app.all "*", routes.error
