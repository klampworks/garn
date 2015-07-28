#lang racket
(require net/url)

(define url-s "http://www.bing.com/")
(define url-u (string->url url-s))

(current-proxy-servers (list (list "http" "192.168.100.1" 4444)))
(define in (get-impure-port url-u))
(define content (port->string in))

(displayln content)

