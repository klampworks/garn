#lang racket
(require "build-query.rkt")
(require "get-url.rkt")
(require "parse-xml.rkt")
(require "config.rkt")

(define keywords (vector-ref (current-command-line-arguments) 0))

(define q
  (add-filter-used
      (add-keyword base-url keywords)))

(define xml (get-url q))

(define items
  (apply-filters
    (xml->items xml)))

(for ([n  items])
        (displayln "########################################")
        (displayln (item-title n))
        (displayln (item-price n))
        (displayln (item-location n))
        (displayln (item-condition n))
        (displayln (item-url n))
        (displayln (item-currency n))
        (displayln "########################################"))

