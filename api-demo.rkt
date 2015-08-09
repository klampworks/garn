#lang racket
(require "build-query.rkt")
(require "get-url.rkt")
(require "parse-xml.rkt")

(define q
  (add-filter-used
      (add-keyword base-url "shellcoder")))

(define xml (get-url q))
(define items (ship-to-uk-only (xml->items xml)))

(for ([n items])
        (displayln "########################################")
        (displayln (item-title n))
        (displayln (item-price n))
        (displayln (item-location n))
        (displayln (item-condition n))
        (displayln (item-url n))
        (displayln (item-shipto n))
        (displayln "########################################"))
