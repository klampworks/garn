#lang racket

(define counter
  (let ([n 0])
    (λ ()
     (set! n (add1 n))
     n)))

(list (counter) (counter) (counter))
