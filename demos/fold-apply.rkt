#lang racket

(define in 1)
(define fns (list add1 add1 add1))
((apply compose fns) in)
