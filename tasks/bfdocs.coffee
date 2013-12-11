path = require 'path'
os = require 'os'
mkdirp = require 'mkdirp'

module.exports = (grunt) ->

  _ = grunt.util._
  bfdocsBin = "#{__dirname}/../node_modules/beautiful-docs/bin/bfdocs"

  grunt.registerMultiTask 'bfdocs', 'Generate beautiful markdown documentation using Grunt', ->

    node = process.execPath
    temp = os.tmpdir()
    done = ->
    manifest = null

    options = @options
      manifest: null
      dest: './out'
      server: false
      port: 8080
      watch: false
      manifestsOnly: false
      title: 'Beautiful Docs'
      baseUrl: ''
      indexOnly: false
      theme: 'default'

    manifestOptions =
      rootDir: null

    bfdocs =
      cmd: node
      grunt: false
      args: null

    args = [ bfdocsBin ].concat buildOptionsArgs options

    # run as async task
    done = @async() unless options.server

    # create folder recursively if it not exists
    mkdirp.sync options.dest

    if options.manifest?
      if Array.isArray options.manifest
        grunt.file.expand options.manifest, (file) ->
          # TODO!
      else if typeof options.manifest is 'string'
        manifest = [ options.manifest ]
      else
        manifest = []
        manifes.push value for own value of options.manifest

    ###
    if @files
      @files.forEach (file) ->
        files = file.src.filter grunt.file.isFile
        bfdocs.args = bfdocs.args.concat files
    ###

    args = args.concat manifest, [ options.dest ]

    # set process arguments
    bfdocs.args = args

    grunt.util.spawn bfdocs, (error, result, code) ->
      if error
        grunt.fail.fatal "Fatal error while running the task: #{error}", 3
        done()
        return

      grunt.log.writeln "Documentation generated in: #{options.dest}"

      if options.server
        grunt.log.writeln "Documentation server listening in port: #{options.port}"

      done()


  buildOptionsArgs = (options) ->
    args = []
    for own flag, value of options when value? and flag isnt 'manifest'
      flag = strToHyphen flag
      args.push "--#{flag}=#{value}"
    args

  strToHyphen = (str) ->
    str.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase()
