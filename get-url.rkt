#lang racket
(provide get-url)
(require net/url)

(define (get-url url-s)
  (call/input-url (string->url url-s) get-pure-port port->string))
