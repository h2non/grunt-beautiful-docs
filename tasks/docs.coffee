path = require 'path'

module.exports = (grunt) ->

  _ = grunt.util._

  grunt.registerMultiTask 'bdocs', 'Generate beautiful markdown documentation using Grunt', ->

    node = process.execPath

    done = @async()
    options = @options
      server: false
      port: 8080
      watch: false
      manifestsOnly: false
      title: 'Beautiful Docs'
      baseUrl: ''
      indexOnly: false
      theme: 'default'



    bdocs =
      cmd: node
      args: generateCommandArgs options

    console.log bdocs.args

    @files.forEach (value) ->
      console.log value

    grunt.util.spawn config, (err, result, code) ->
      console.log err, result, code
      done()


  generateCommandArgs = (options) ->
    args = []
    for own flag, value of options
      flag = strToHyphen flag
      args.push "--#{flag}"
      args.push value

    args


  strToHyphen = (str) ->
    str.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase()
