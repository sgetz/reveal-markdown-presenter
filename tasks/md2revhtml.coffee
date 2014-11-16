require('coffee-script/register')
md = require('../node_modules/reveal.js/plugin/markdown/markdown')
path = require('path')
md2RevHtml = (grunt) ->
  taskFn = ->
    mdsrcpath = this.options().src
    htmldest = this.options().dest
    templatefile = this.options().templatefile
    replacestr = this.options().replacestr
    example_code_path = this.options().example_code_path

    codeExampleRegex = /codeExample: ?([A-Za-z]\w+\.(\w+))/gi


    mdsrc = grunt.file.read(mdsrcpath)
    replacerFn = (match, filename, fileext, fullstr) ->
      console.log example_code_path
      filepath = path.join example_code_path, filename
      filecontnet = grunt.file.read(filepath)
      return """```#{fileext}\n#{filecontnet}\n```"""
    mdsrc_with_code = mdsrc.replace(codeExampleRegex, replacerFn)


    template_file_text = grunt.file.read(templatefile)

    slidehtml = md.slidify(mdsrc_with_code)
    out_html = template_file_text.replace(replacestr, slidehtml)
    grunt.file.write(htmldest, out_html)
    return

  grunt.registerTask 'md2RevHtml', '', taskFn

module.exports = md2RevHtml
