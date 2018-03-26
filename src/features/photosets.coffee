import $ from 'jquery'

$ ->
  ps = $ 'li.photoset'
  ps.find '.photo-slideshow'
    .css display: 'block'
    .pxuPhotoset rounded: false
  , ->
    # Once the responsive photoset loads, hide the nonresponsive one
    ps.find '.html_photoset'
      .remove()
