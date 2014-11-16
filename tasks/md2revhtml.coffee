require('coffee-script/register')
md = require('../node_modules/reveal.js/plugin/markdown/markdown')
path = require('path')
md2RevHtml = (grunt) ->
  taskFn = ->
    presentationTemplateInsertPoint = '<!-- INSERT SLIDES HERE -->'
    customTagsRegExGenerator = (pattern) -> new RegExp("<!-- ?#{pattern} ?-->", 'ig')

    files = @files
    options = @options()
    presentationTemplate = options.presentationTemplate
    preprocessors = options.preprocessors
    searchPath = options.searchPath

    writePresentationHtml = (slides) ->
      presentationTemplateHtml = grunt.file.read presentationTemplate
      presentationTemplateHtml.replace(presentationTemplateInsertPoint, slides)

    readFileFromSearchPath = (filePath) ->
      fullPath = path.join searchPath, filePath
      grunt.file.read fullPath

    for file in files
      src = file.src
      dest = file.dest
      presentationMd = grunt.file.read src
      for own pattern, cb of preprocessors
        patternRe = customTagsRegExGenerator pattern
        presentationMd = presentationMd.replace(patternRe, (args...) -> cb(args..., readFileFromSearchPath))
      revealJsSlides = md.slidify(presentationMd, {separator: '^\n---\n$', verticalSeparator: '^\n----\n$'})
      presentationHtml = writePresentationHtml revealJsSlides
      grunt.file.write dest, presentationHtml
      grunt.log.write "md2RevHtml: Finished Writing To #{dest}"

  grunt.registerMultiTask 'md2RevHtml', '', taskFn

module.exports = md2RevHtml
