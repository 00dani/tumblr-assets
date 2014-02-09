module.exports = (grunt) ->
  grunt.loadNpmTasks 'compilist'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-includes'

  grunt.initConfig
    compilist: app:
      src: ['src/app.coffee']
      dest: 'dist/app.js'
    stylus: style:
      src: ['src/style.styl']
      dest: 'dist/style.css'
    includes: theme:
      src: ['src/theme.html']
      dest: 'dist/theme.html'
      options: includePath: '.'
    clean: theme:
      src: ['dist']

  grunt.registerTask 'theme', ['stylus:style', 'includes:theme']
  grunt.registerTask 'watchapp', ['compilist:app:keepalive']

  grunt.registerTask 'default', ['theme']
