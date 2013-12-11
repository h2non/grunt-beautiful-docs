grunt = require 'grunt'

exports.docs =

  sample: (test) ->
    test.expect 3

    expected = grunt.file.read 'test/expected/sample/index.html'
    actual = grunt.file.read '.tmp/sample/index.html'
    test.equal expected, actual, 'should generate index.html properly'

    expected = grunt.file.read 'test/expected/sample/readme.html'
    actual = grunt.file.read '.tmp/sample/readme.html'
    test.equal expected, actual, 'should generate readme.html properly'

    expected = grunt.file.read 'test/expected/sample/all.html'
    actual = grunt.file.read '.tmp/sample/all.html'
    test.equal expected, actual, 'should generate all.html properly'

    test.done()
