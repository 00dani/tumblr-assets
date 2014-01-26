module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-includes'

  grunt.initConfig
    stylus: style:
      src: ['style.styl']
      dest: 'dist/style.css'
    includes: theme:
      src: ['theme.html']
      dest: 'dist/theme.html'
    clean: theme:
      src: ['dist']

  grunt.registerTask 'theme', ['stylus:style', 'includes:theme']
