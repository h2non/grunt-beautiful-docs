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

  onlyOptions: (test) ->
    test.expect 3

    expected = grunt.file.read 'test/expected/options/index.html'
    actual = grunt.file.read '.tmp/sample/index.html'
    test.equal expected, actual, 'should generate index.html properly'

    expected = grunt.file.read 'test/expected/options/readme.html'
    actual = grunt.file.read '.tmp/options/readme.html'
    test.equal expected, actual, 'should generate readme.html properly'

    expected = grunt.file.read 'test/expected/options/all.html'
    actual = grunt.file.read '.tmp/options/all.html'
    test.equal expected, actual, 'should generate all.html properly'

    test.done()

  manifests: (test) ->
    test.expect 3

    expected = grunt.file.read 'test/expected/super-awesome-docs/index.html'
    actual = grunt.file.read 'out/super-awesome-docs/index.html'
    test.equal expected, actual, 'should generate index.html properly'

    expected = grunt.file.read 'test/expected/super-awesome-docs/docs.html'
    actual = grunt.file.read 'out/super-awesome-docs/docs.html'
    test.equal expected, actual, 'should generate docs.html properly'

    expected = grunt.file.read 'test/expected/super-awesome-docs/all.html'
    actual = grunt.file.read 'out/super-awesome-docs/all.html'
    test.equal expected, actual, 'should generate all.html properly'

    test.done()

  manifestObj: (test) ->
    test.expect 4

    expected = grunt.file.read 'test/expected/manifest/index.html'
    actual = grunt.file.read '.tmp/manifest/index.html'
    test.equal expected, actual, 'should generate index.html properly'

    expected = grunt.file.read 'test/expected/manifest/changelog.html'
    actual = grunt.file.read '.tmp/manifest/changelog.html'
    test.equal expected, actual, 'should generate changelog.html properly'

    expected = grunt.file.read 'test/expected/manifest/docs.html'
    actual = grunt.file.read '.tmp/manifest/docs.html'
    test.equal expected, actual, 'should generate docs.html properly'

    expected = grunt.file.read 'test/expected/manifest/all.html'
    actual = grunt.file.read '.tmp/manifest/all.html'
    test.equal expected, actual, 'should generate all.html properly'

    test.done()
