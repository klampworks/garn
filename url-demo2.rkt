#lang racket
(require net/url)

(define url-s "http://www.bing.com/")
(define url-u (string->url url-s))

(current-proxy-servers (list (list "http" "127.0.0.1" 8123)))
(define in (get-impure-port url-u))
(define content (port->string in))

(displayln content)

