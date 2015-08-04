#lang racket
(require "build-query.rkt")
(require "get-url.rkt")
(require "parse-xml.rkt")

(define q (add-filter-gbp (add-keyword base-url "harry potter")))
(displayln (get-url q))
