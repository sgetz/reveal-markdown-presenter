###Allow Requiring Coffeescript Modules###
require('coffee-script/register')
gruntFunction = (grunt) ->
  ###Load Grunt Tasks###
  #sometask = require('./tasks/sometask')
  require('./tasks/md2revhtml')(grunt)
  require('load-grunt-tasks')(grunt)

  ###Path###
  presdir = 'presentation'
  curdir = __dirname
  pesfile = '<%= curdir %>/<%= presdir %>/presentation.md'
  srcdir = 'src'
  bowerdir = 'bower_components'
  tmpdir = '.tmp'

  md2RevHtml =
    options:
      src: '<%= pesfile %>'
      templatefile: '<%= srcdir %>/index.tpl.html'
      replacestr: '<!-- INSERT SLIDES HERE -->'
      dest: '<%= tmpdir %>/presentation.html'
      example_code_path: '<%= curdir %>/<%= presdir %>/example-code'

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
      files:
        expand: true
        cwd: '<%= presdir %>/example-code'
        src: ['*.less']
        dest: '<%= presdir %>/example-code'
        ext: '.css'
    presentation_styles:
      files:
        expand: true
        cwd: '<%= presdir %>'
        src: ['styles.less']
        dest: '<%= tmpdir %>'
        ext: '.css'
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
  }

  ###Grunt Watch Config###
  watch = {
    options:
      livereload: true
    less:
      files: ['<%= presdir %>/**/*.less']
      tasks: ['less', ]

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
    copy
    connect
    coffee
    less
    watch
  }

  ###Register Default Grunt Task###
  grunt.registerTask 'default', [
    'less'
    'copy'
    'connect:dev'
    'watch'
  ]

  ###Init Grunt With gruntConfig###
  grunt.initConfig gruntConfig



###Export The Grunt Function###
module.exports = gruntFunction
