path = require 'path'
mkdirp = require 'mkdirp'

module.exports = (grunt) ->

  _ = grunt.util._
  bfdocsBin = "#{__dirname}/../node_modules/beautiful-docs/bin/bfdocs"

  grunt.registerMultiTask 'bfdocs', 'Generate beautiful markdown documentation using Grunt', ->

    node = process.execPath
    done = @async()

    manifestData = null
    manifests = []
    filename = null

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

    args = [ bfdocsBin ]

    if options.manifest?
      if Array.isArray(options.manifest) or typeof options.manifest is 'string'
        grunt.file.expand(options.manifest).forEach (file) ->
          manifests.push file
        if manifests.length > 1
          options.manifestsOnly = true
      else if typeof options.manifest is 'object'
        manifestData = options.manifest

        if Array.isArray manifestData.files
          manifestData.files = grunt.file.expand(manifestData.files)
            .filter (file) -> grunt.file.isFile file
    else
      grunt.fail.fatal "'manifest' option is required"

    # manifest files
    if Array.isArray(@files) and @files.length and manifestData?
      @files.forEach (file) ->
        options.dest = file.dest if file.dest and options.dest is './out'
        files = file.src.filter (file) -> grunt.file.isFile file
        manifestData.files = [] unless Array.isArray manifestData.files
        manifestData.files.concat files

    # write JSON manifest, if required
    if manifestData?
      writeManifestFile filename = manifestFilename(), manifestData
      manifests.push filename

    # build command arguments
    args = args.concat buildOptionsArgs(options), manifests, [ options.dest ]

    # create folder recursively if it not exists
    mkdirp.sync options.dest

    # set process arguments
    bfdocs.args = args

    grunt.verbose.writeln "Executing command: \n#{bfdocs.cmd}\n#{bfdocs.args.join(' ')}"

    if options.server
      grunt.log.writeln "Documentation server listening in port: #{options.port}"

    # todo: kill spawn process on exit
    spawn = grunt.util.spawn bfdocs, (error, result, code) ->
      if error
        grunt.fail.fatal "cannot run the task: #{error}", 3
        done()
        return

      grunt.log.writeln "Documentation generated in: #{options.dest}"

      # clean file
      deleteManifestFile filename if filename

      done()

      # kill spawn process when node process exit
      process.on 'exit', ->
        spawn.kill('SIGKILL')


  manifestFilename = ->
    "bfdocs-manifest-#{new Date().getTime()}.json"

  writeManifestFile = (filename, data) ->
    try
      grunt.verbose.writeln "Creating manifest temporary file: #{filename}"
      grunt.file.write filename, JSON.stringify(data, null, 4)
    catch e
      grunt.fail.fatal "cannot write the temporal manifest file:\n#{e.message}"

  deleteManifestFile = (filepath) ->
    grunt.file.delete filepath, force: true

  isNotReservedFlag = (flag) ->
    [ 'manifest', 'dest' ].indexOf(flag) is -1

  notEmpty = (value) ->
    if value?
      if typeof value is 'string'
        if value.length
          return yes
      else
        return yes
    no

  buildOptionsArgs = (options) ->
    args = []
    for own flag, value of options when notEmpty(flag) and isNotReservedFlag flag
      flag = strToHyphen flag
      if typeof value is 'boolean'
        if value is true
          args.push "--#{flag}"
      else
        if typeof value is 'string' and value.length
          if value.indexOf(' ') isnt -1
            value = '"' + value + '"'
          args.push "--#{flag}=#{value}"
    args

  strToHyphen = (str) ->
    str.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase()
