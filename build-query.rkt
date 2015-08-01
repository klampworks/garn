#lang racket

(define API-KEY (getenv "EBAY_API_KEY"))

(define base-url 
  (string-append 
    "http://svcs.ebay.com/services/search/FindingService/v1?"
    "OPERATION-NAME=findItemsByKeywords"
    "&SERVICE-VERSION=1.0.0"
    "&SECURITY-APPNAME=" API-KEY
    "&RESPONSE-DATA-FORMAT=XML"
    "&REST-PAYLOAD"))

(displayln base-url)
