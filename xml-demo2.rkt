#lang at-exp racket
(require xml xml/path)
(require racket/port)

(define input (open-input-file "input"))
(define data 
    (read-xml input))

(write-xexpr (xml->xexpr (document-element data)))
