#lang racket
(require "parse-xml.rkt")
(require racket/port)

(define input (port->string (open-input-file "input")))
(for ([n (xml->items input)])
        (displayln "########################################")
        (displayln (item-title n))
        (displayln (item-url n))
        (displayln "########################################"))
