module.exports = (req, res, next)->
   console.log req.session
   res.render "404",
      title: "404"
      js: req.coffee.renderTags()
      css: req.less.renderTags()
