module.exports = (grunt) ->
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    clean: ['.tmp/**', 'tasks/*.js', 'test/**/*.js']

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
          'tasks/docs.js': 'tasks/docs.coffee'
      options:
        bare: true

    bdocs:
      sample:
        options:
          server: false
          title: 'Sample docs'

    nodeunit:
      tests: ['test/*_test.coffee']

  grunt.loadTasks 'tasks'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-nodeunit'

  grunt.registerTask 'default', ['clean', 'coffeelint', 'coffee']
  grunt.registerTask 'test', ['clean', 'coffeelint', 'coffee', 'bdocs', 'nodeunit']
