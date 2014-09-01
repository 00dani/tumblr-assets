$ = require 'jquery'
prettify = 'https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?skin=sunburst&autoload=false'

lang = /^lang: (\w+)$/

$.getScript prettify, -> $ ->
  $ 'pre'
    .addClass 'prettyprint'
    .each (i, e) ->
      $e = $ e
      lines = $e.text().split '\n'
      if m = lang.exec lines[0]
        $e.addClass "lang-#{m[1]}"
        $e.text lines[1..].join '\n'
  prettyPrint?()
