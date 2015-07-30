#lang racket
(require xml xml/path)
(require racket/port)
(require srfi/26)
(provide xml->items)
(provide (struct-out item))

(struct item (title price location condition url))

(define (xml->item n)
  (apply item 
         (map (cut se-path* <> n) '((title)
                                    (currentPrice)
                                    (location)
                                    (conditionDisplayName)
                                    (viewItemURL)))))

(define (wrap-items xml-s)
  (let ([t
          (regexp-replace* "<item>" xml-s "<item-wrapper><item>")])
    (regexp-replace* #rx"</item>" t "</item></item-wrapper>")))

(define (parse-item-nodes xml-s) 
  (se-path*/list '(item-wrapper) (string->xexpr xml-s)))

(define (item-nodes->items item-nodes) (map xml->item item-nodes))

(define (xml->items xml-s)
  (item-nodes->items (parse-item-nodes (wrap-items xml-s))))
