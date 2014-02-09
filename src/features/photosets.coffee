$ = require 'Extended-Tumblr-Photoset'

$ ->
  ps = $ 'li.photoset'
  ps.find '.photo-slideshow'
    .pxuPhotoset rounded: false
  , ->
    ($ @).css display: 'block'
    ps.find '.html_photoset'
      .remove()
