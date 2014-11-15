###Allow Requiring Coffeescript Modules###
require('coffee-script/register')
gruntFunction = (grunt) ->
  ###Load Grunt Tasks###
  #sometask = require('./tasks/sometask')
  require('load-grunt-tasks')(grunt)
  
  ###GruntConfig Object###
  gruntConfig = {
  
  }
  
  ###Init Grunt With gruntConfig###
  grunt.initConfig gruntConfig
    
  

###Export The Grunt Function###
module.exports = gruntFunction