#lang racket
(require net/uri-codec)

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

(displayln (add-keyword base-url "harry potter"))
