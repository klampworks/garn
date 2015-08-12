#lang racket
(require "parse-xml.rkt")
(provide apply-filters)
(require net/url)

(define filters 
  (list 
    convert-currency 
    ship-to-uk-only))

(define (apply-filters items)
  ((apply compose filters) items))

;socksParentProxy = localhost:9050
;;dnsUseGethostbyname = no
(current-proxy-servers (list (list "http" "127.0.0.1" 8123)))
