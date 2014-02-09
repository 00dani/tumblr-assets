module.exports = (grunt) ->
  grunt.loadNpmTasks 'compilist'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-includes'

  grunt.renameTask 'watch', 'contrib_watch'

  grunt.initConfig
    compilist: app:
      src: ['src/app.coffee']
      dest: 'dist/app.js'
    copy: publish:
      expand: true
      cwd: 'dist/'
      src: ['*']
      dest: "#{process.env.HOME}/gopsychonauts@gmail.com/tumblr/"

    stylus: style:
      src: ['src/style.styl']
      dest: 'dist/style.css'
    includes: theme:
      src: ['src/theme.html']
      dest: 'dist/theme.html'
      options: includePath: '.'
    clean: theme:
      src: ['dist', 'distgz']

    contrib_watch: dist:
      files: ['dist/*']
      tasks: 'copy'

  grunt.registerTask 'theme', ['stylus:style', 'includes:theme']

  grunt.registerTask 'watch', ['theme', 'compilist:app', 'contrib_watch:dist']
  grunt.registerTask 'publish', ['theme', 'compilist:app', 'copy']

  grunt.registerTask 'default', ['theme']
