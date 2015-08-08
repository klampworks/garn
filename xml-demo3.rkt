#lang racket
(require "parse-xml.rkt")
(require racket/port)

(define input (port->string (open-input-file "input")))

(define items (xml->items input))
(for ([n items])
        (displayln "########################################")
        (displayln (item-title n))
        (displayln (item-price n))
        (displayln (item-location n))
        (displayln (item-condition n))
        (displayln (item-url n))
        (displayln (item-shipto n))
        (displayln "########################################"))
