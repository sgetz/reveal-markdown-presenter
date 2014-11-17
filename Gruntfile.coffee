###Allow Requiring Coffeescript Modules###
require('coffee-script/register')
gruntFunction = (grunt) ->
  ###Load Grunt Tasks###
  #sometask = require('./tasks/sometask')
  require('./tasks/md2revhtml')(grunt)
  require('load-grunt-tasks')(grunt)

  marked = require('marked')
  marked.setOptions({
    renderer: new marked.Renderer(),
    gfm: true,
    tables: true,
    breaks: false,
    pedantic: false,
    sanitize: true,
    smartLists: true,
    smartypants: false
  })

  ###Path###
  presdir = 'presentation'
  curdir = __dirname
  pesfile = '<%= curdir %>/<%= presdir %>/presentation.md'
  srcdir = 'src'
  bowerdir = 'bower_components'
  tmpdir = '.tmp'

  md2RevHtml =
    presentation:
      files:
        '<%= tmpdir %>/presentation.html': '<%= pesfile %>'
      options:
        presentationTemplate: '<%= curdir %>/tasks/reveal-js.tpl.html'
        searchPath: '<%= curdir %>/<%= presdir %>/example-code'
        preprocessors:
          'codeExample: ?([A-Za-z0-9]+\\.([A-Za-z]+))': (match, filename, fileext, other..., readFileFn) ->
            fileContent = readFileFn(filename)
            return """```#{fileext}\n#{fileContent}\n```"""
          'codeExampleSideBySide: ?([A-Za-z0-9]+\\.([A-Za-z]+)) ?\\| ?([A-Za-z0-9]+\\.([A-Za-z]+))': (match, fileOneName, fileOneExt, fileTwoName, fileTwoExt, other..., readFileFn) ->
            fileOneContent = readFileFn(fileOneName)
            fileTwoContent = readFileFn(fileTwoName)
            fileOneContentAsMarkdown = """```#{fileOneExt}\n#{fileOneContent}\n```"""
            fileTwoContentAsMarkdown = """```#{fileTwoExt}\n#{fileTwoContent}\n```"""
            fileOneContentAsHtml = marked(fileOneContentAsMarkdown)
            fileTwoContentAsHtml = marked(fileTwoContentAsMarkdown)
            return """<div class="side-by-side-code">
              <div class="left-code">#{fileOneContentAsHtml}</div>
              <div class="right-code">#{fileTwoContentAsHtml}</div>
            </div>"""

  clean = {
    tmp: ['<%= tmpdir %>']
  }

  ###Grunt Copy Config###
  copy = {
    index_html:
      src: '<%= srcdir %>/index.tpl.html'
      dest: '<%= tmpdir %>/index.html'
      options:
        processContent: (content, srcpath) -> grunt.template.process(content)
    bower_components:
      expand: true
      cwd: '<%= bowerdir %>/'
      src: ['**/*']
      dest: '<%= tmpdir %>/bower_components'
    presentation_images:
      expand: true
      cwd: '<%= presdir %>/images'
      dest: '<%= tmpdir %>/images'
      src: '**/*'
  }

  ###Grunt Coffee Config###
  coffee = {}

  ###Grunt Less Config###
  less = {
    presentation_sample_less:
      options:
        paths: ['<%= presdir %>/example-code']
      files: [{
        expand: true
        cwd: '<%= presdir %>/example-code'
        src: ['*.less']
        dest: '<%= presdir %>/example-code'
        ext: '.css'
      }]
    presentation_styles:
      options:
        paths: ['<%= presdir %>', '<%= bowerdir %>']
      files: [{
        expand: true
        cwd: '<%= presdir %>'
        src: ['styles.less']
        dest: '<%= tmpdir %>'
        ext: '.css'
      }]
  }

  ###Grunt Connect Config###
  connect = {
    options:
      hostname: '*'
      protocol: 'http'
      port: 8443
    dev:
      options:
        base: ['<%= tmpdir %>']
        livereload: true
        middleware: (connect, options) ->
          options.base = [options.base] if not Array.isArray(options.base)
          middlewares = []
          for base in options.base
            middlewares.push connect.static(base)
          middlewares

  }

  ###Grunt Watch Config###
  watch = {
    options:
      livereload: true
    less:
      files: ['<%= presdir %>/**/*.less']
      tasks: ['less', 'md2RevHtml']
    md:
      files: ['<%= presdir %>/**/*.md']
      tasks: ['less', 'md2RevHtml']


  }

  ###GruntConfig Object###
  gruntConfig = {
    presdir
    curdir
    bowerdir
    pesfile
    srcdir
    tmpdir
    md2RevHtml
    clean
    copy
    connect
    coffee
    less
    watch
  }

  ###Register Default Grunt Task###
  grunt.registerTask 'default', [
    'clean'
    'md2RevHtml'
    'less'
    'copy'
    'connect:dev'
    'watch'
  ]

  ###Init Grunt With gruntConfig###
  grunt.initConfig gruntConfig



###Export The Grunt Function###
module.exports = gruntFunction
