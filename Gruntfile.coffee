module.exports = (grunt) ->
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    clean: ['.tmp/**', 'out/**', 'tasks/*.js', 'test/**/*.js']

    coffeelint:
      tasks: 'tasks/*.coffee'
      test: 'test/*.coffee'
      grunt: 'Gruntfile.coffee'
      options:
        max_line_length:
          value: 120
          level: 'warn'
        no_trailing_whitespace:
          level: 'warn'
        no_tabs:
          level: 'error'
        indentation:
          value: 2
          level: 'error'

    coffee:
      tasks:
        files:
          'tasks/bfdocs.js': 'tasks/bfdocs.coffee'
      options:
        bare: true

    bfdocs:
      sample:
        options:
          title: 'Sample docs'
          manifest: 'test/fixtures/sample/manifest.json'
          dest: '.tmp/sample'
        files:
          './tmp/sample': [ 'test/fixtures/sample/*.md' ]

      onlyOptions:
        options:
          title: 'Sample docs options'
          manifest: 'test/fixtures/sample/manifest.json'
          dest: '.tmp/options'

      manifests:
        options:
          title: 'Sample docs manifest'
          manifest: [ 'test/fixtures/manifests/*.json' ]
        files: [
          {
            src: [ 'test/fixtures/manifests/**/*.md' ]
            dest: '.tmp/manifests'
          }
        ]

      manifestObj:
        options:
          title: 'Sample object manifest'
          dest: '.tmp/manifest'
          manifest:
            title: 'Super awesome docs'
            files: [ 'test/fixtures/manifests/docs/*.md' ]


    nodeunit:
      tests: ['test/*_test.coffee']

  grunt.loadTasks 'tasks'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-nodeunit'
  grunt.loadNpmTasks 'grunt-release'

  grunt.registerTask 'default', ['clean', 'coffeelint', 'coffee']
  grunt.registerTask 'test', ['default', 'bfdocs', 'nodeunit']
