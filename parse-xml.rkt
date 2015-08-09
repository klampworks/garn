#lang racket
(require xml xml/path)
(require racket/port)
(require srfi/26)
(provide xml->items)
(provide (struct-out item))
(provide ship-to-uk-only)

(struct item (title price location condition url shipto))

(define (mk-item t p l c u [s '()])
  (item t p l c u s))

(define (xml->item n)
  (apply mk-item 
         (append
           (map (cut se-path* <> n) '((title)
                                    (currentPrice)
                                    (location)
                                    (conditionDisplayName)
                                    (viewItemURL))) 
           (list (se-path*/list '(shipToLocations) n)))))

(define (ship-to-uk-only items)
  (filter (λ (i)
             (foldr (λ (c acc) (or acc
                                   (string=? "GB" c)
                                   (string=? "UK" c)
                                   (string=? "Worldwide" c)))
                    #f (item-shipto i)))
          items))

(define (wrap-items xml-s)
  (let ([t
          (regexp-replace* "<item>" xml-s "<item-wrapper><item>")])
    (regexp-replace* #rx"</item>" t "</item></item-wrapper>")))

(define (parse-item-nodes xml-s) 
  (se-path*/list '(item-wrapper) (string->xexpr xml-s)))

(define (item-nodes->items item-nodes) (map xml->item item-nodes))

(define (xml->items xml-s)
  (item-nodes->items (parse-item-nodes (wrap-items xml-s))))
