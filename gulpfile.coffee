'use strict'

gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

nib = require 'nib'
webpack = require 'webpack'
webpackStream = require 'webpack-stream'

hash = (require 'git-rev-sync').short()
dist = "dist/#{hash}/"

buildApp = (conf) ->
  gulp.src 'src/app.coffee'
    .pipe webpackStream conf, webpack
    .pipe gulp.dest dist

app = -> buildApp require './webpack.config'
appWatch = ->
	conf = require './webpack.config'
	conf.watch = true
	buildApp conf

gulp.task app

theme = ->
  context = {hash}
  gulp.src 'src/*.hbs'
    .pipe $.staticHandlebars context, partials: gulp.src 'src/*.hbs'
    .pipe $.rename extname: '.html'
    .pipe gulp.dest dist
gulp.task theme

style = ->
  gulp.src 'src/style.styl'
    .pipe $.sourcemaps.init loadMaps: true
    .pipe $.stylus use: nib(), compress: true
    .pipe $.sourcemaps.write './'
    .pipe gulp.dest dist
gulp.task style

monoid = ->
  $.download 'https://cdn.rawgit.com/larsenwork/monoid/2db2d289f4e61010dd3f44e09918d9bb32fb96fd/Monoid.zip'
    .pipe $.decompress()
    .pipe $.ignore.include '*.ttf'
    .pipe $.ttf2eot clone: true
    .pipe $.ttf2woff clone: true
    .pipe $.ttf2woff2 clone: true
    .pipe gulp.dest dist + '/fonts/'
gulp.task monoid

gulp.task 'default', gulp.parallel monoid, theme, style, app
gulp.task 'watch', ->
  gulp.watch 'src/*.hbs', theme
  gulp.watch 'src/*.styl', style
  gulp.watch './webpack.config.coffee', appWatch
  appWatch()
