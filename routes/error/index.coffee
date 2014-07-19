module.exports = (req, res, next)->
   res.render "404",
      title: "404"
      js: req.coffee.renderTags()
      css: req.less.renderTags()
