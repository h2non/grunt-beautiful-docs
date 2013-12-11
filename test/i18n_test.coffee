grunt = require 'grunt'

exports.docs =

  translateFile: (test) ->
    test.expect 2

    expected = grunt.file.read 'test/expected/en_US/sample.html'
    actual = grunt.file.read '.tmp/en_US/sample.html'
    test.equal expected, actual, 'should translate the template into english'

    expected = grunt.file.read 'test/expected/es_ES/sample.html'
    actual = grunt.file.read '.tmp/es_ES/sample.html'
    test.equal expected, actual, 'should translate the template into spanish'

    test.done()
