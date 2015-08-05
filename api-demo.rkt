#lang racket
(require "build-query.rkt")
(require "get-url.rkt")
(require "parse-xml.rkt")

(define q (add-filter-gbp (add-keyword base-url "harry potter")))
(define xml (get-url q))
(define items (xml->items xml))

(for ([n items])
        (displayln "########################################")
        (displayln (item-title n))
        (displayln (item-price n))
        (displayln (item-location n))
        (displayln (item-condition n))
        (displayln (item-url n))
        (displayln "########################################"))
