'use strict'

gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

buffer = require 'vinyl-buffer'
log = require 'gulplog'
nib = require 'nib'
source = require 'vinyl-source-stream'

browserifyOpts = {
  debug: true
  entries: ['src/app.coffee']
  extensions: ['.coffee']
  transform: ['coffeeify', 'cssify']
}
b = (require 'browserify') browserifyOpts
b.on 'log', log.info

app = ->
  b.bundle()
    .on 'error', log.error.bind log, 'Browserify Error'
    .pipe source 'app.js'
    .pipe buffer()
    .pipe $.sourcemaps.init loadMaps: true
    .pipe $.babel compact: false, presets: ['env']
    .pipe $.uglify()
    .pipe $.sourcemaps.write './'
    .pipe gulp.dest 'dist/'

b.on 'update', app
gulp.task app

theme = ->
  context = {}
  gulp.src 'src/*.hbs'
    .pipe $.staticHandlebars context, partials: gulp.src 'src/*.hbs'
    .pipe $.rename extname: '.html'
    .pipe gulp.dest 'dist/'
gulp.task theme

style = ->
  gulp.src 'src/style.styl'
    .pipe $.sourcemaps.init loadMaps: true
    .pipe $.stylus use: nib(), compress: true
    .pipe $.sourcemaps.write './'
    .pipe gulp.dest 'dist/'
gulp.task style

monoid = ->
  $.download 'https://cdn.rawgit.com/larsenwork/monoid/2db2d289f4e61010dd3f44e09918d9bb32fb96fd/Monoid.zip'
    .pipe $.decompress()
    .pipe $.ignore.include '*.ttf'
    .pipe $.ttf2eot clone: true
    .pipe $.ttf2woff clone: true
    .pipe $.ttf2woff2 clone: true
    .pipe gulp.dest 'dist/fonts/'
gulp.task monoid

gulp.task 'default', gulp.parallel monoid, theme, style, app
gulp.task 'watch', ->
  gulp.watch 'src/*.hbs', theme
  gulp.watch 'src/*.styl', style
  b.plugin 'watchify'
  app()
