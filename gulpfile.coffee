'use strict'

gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

buffer = require 'vinyl-buffer'
nib = require 'nib'
source = require 'vinyl-source-stream'


browserifyOpts = {
  debug: true
  entries: ['src/app.coffee']
  extensions: ['.coffee']
  transform: ['coffeeify', 'cssify']

  cache: {}
  packageCache: {}
}
b = (require 'browserify') browserifyOpts
b.on 'log', $.util.log

bundle = ->
  b.bundle()
    .pipe source 'app.js'
    .pipe buffer()
    .pipe $.sourcemaps.init loadMaps: true
    .pipe $.sourcemaps.write './'
    .pipe gulp.dest 'dist/'

b.on 'update', bundle
gulp.task 'app', bundle

gulp.task 'theme', ->
  gulp.src 'src/*.html'
    .pipe $.include()
    .pipe gulp.dest 'dist/'

gulp.task 'style', ->
  gulp.src 'src/style.styl'
    .pipe $.sourcemaps.init loadMaps: true
    .pipe $.stylus use: nib(), compress: true
    .pipe $.sourcemaps.write './'
    .pipe gulp.dest 'dist/'

gulp.task 'watch', ->
  gulp.watch 'src/*.html', ['theme']
  gulp.watch 'src/*.styl', ['style']
  b.plugin 'watchify'
  bundle()
