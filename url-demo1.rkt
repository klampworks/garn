#lang racket
(require net/url)

(define url-s "http://www.bing.com/")
(define url-u (string->url url-s))
(define in (get-impure-port url-u))
(define content (port->string in))

(displayln content)

