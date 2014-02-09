$ = require 'jquery'

peeps = []

$ ->
  $ '*:not(blockquote) > p + blockquote'
    .filter ->
      $ @
        .find 'blockquote'
        .length > 5
    .addClass 'long'
    .find 'blockquote'
    .each ->
      peep = ($ @).prev('p').text()
      if peep not in peeps
        peeps.push peep
      ($ @).addClass "peep_#{peeps.indexOf peep}"

