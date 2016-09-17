module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-exorcise'
  grunt.loadNpmTasks 'grunt-includes'

  grunt.renameTask 'watch', 'contrib_watch'

  grunt.initConfig
    browserify:
      options:
        transform: ['coffeeify', 'cssify']
        browserifyOptions:
          debug: true
          extensions: ['.coffee']
      app: files: 'dist/app.js': 'src/app.coffee'
      watchApp:
        files: 'dist/app.js': 'src/app.coffee'
        options: watch: true

    exorcise:
      app: files: 'dist/app.js.map': ['dist/app.js']

    stylus: style:
      src: ['src/style.styl']
      dest: 'dist/style.css'

    includes:
      theme:
        src: ['src/theme.html']
        dest: 'dist/theme.html'
      redirect:
        src: ['src/redirect.html']
        dest: 'dist/redirect.html'
      options: includePath: '.'

    contrib_watch:
      theme:
        files: ['src/theme.html']
        tasks: 'includes:theme'
      redirect:
        files: ['src/redirect.html', 'src/theme.html']
        tasks: 'includes:redirect'
      style:
        files: ['src/style.styl']
        tasks: 'stylus:style'

  grunt.registerTask 'theme', ['stylus:style', 'includes']

  grunt.registerTask 'watch', ['browserify:watchApp', 'contrib_watch']
  grunt.registerTask 'publish', ['theme', 'browserify:app', 'exorcise:app']

  grunt.registerTask 'default', ['theme']
