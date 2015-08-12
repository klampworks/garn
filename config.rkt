#lang racket
(require "parse-xml.rkt")
(provide apply-filters)

(define filters 
  (list 
    convert-currency 
    ship-to-uk-only))

(define (apply-filters items)
  ((apply compose filters) items))
