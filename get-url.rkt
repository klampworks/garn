#lang racket
(provide get-url)
(require net/url)

;socksParentProxy = localhost:9050
;;dnsUseGethostbyname = no
(current-proxy-servers (list (list "http" "127.0.0.1" 8123)))

(define (get-url url-s)
  (call/input-url (string->url url-s) get-impure-port port->string))
