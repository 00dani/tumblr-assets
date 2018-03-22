import $ from 'jquery'

peeps = []
addPeepClass = (i, e) ->
  peep = ($ e).prev('p').text()
  if peep not in peeps
    peeps.push peep
  ($ e).addClass "peep_#{peeps.indexOf peep}"

$ ->
  $ '*:not(blockquote) > p + blockquote'
    .filter ->
      $ @
        .find 'blockquote'
        .length >= 5
    .addClass 'long'
    .each addPeepClass
    .find 'blockquote'
    .each addPeepClass
