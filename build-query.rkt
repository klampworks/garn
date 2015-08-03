#lang racket
(require net/uri-codec)
(provide base-url)
(provide add-keyword)
(provide add-filter)
(provide add-filter-gbp)

(define API-KEY (getenv "EBAY_API_KEY"))

(define base-url 
  (string-append 
    "http://svcs.ebay.com/services/search/FindingService/v1?"
    "OPERATION-NAME=findItemsByKeywords"
    "&SERVICE-VERSION=1.0.0"
    "&SECURITY-APPNAME=" API-KEY
    "&RESPONSE-DATA-FORMAT=XML"
    "&REST-PAYLOAD"))

(define (add-keyword url keyword)
  (string-append url "&keywords=" (uri-encode keyword)))

(define filter-counter
  (let ([n -1])
    (λ () (set! n (add1 n)) n)))

(define (add-filter url name value)
  (let ([f (format "&itemFilter(~a)" (filter-counter))])
    (string-append url f ".name=" name f ".value=" value)))

(define (add-filter-gbp url)
  (add-filter url "Currency" "GBP"))
