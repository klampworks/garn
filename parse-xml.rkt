#lang racket
(require xml xml/path)
(require racket/port)
(require srfi/26)
(provide xml->items)
(provide (struct-out item))
(provide ship-to-uk-only)
(provide convert-currency)

(struct item (title
               [price #:mutable] location condition url
               shipto [currency #:mutable]))

(define (mk-item t l c u p cu [s '()])
  (item t p l c u s cu))

(define (xml->item n)
  (apply mk-item 
         (append
           (map (cut se-path* <> n) '((title)
                                    (location)
                                    (conditionDisplayName)
                                    (viewItemURL)))
           (list (string->number (se-path* '(currentPrice) n)))
           (list (se-path* '(currentPrice #:currencyId) n))
           (list (se-path*/list '(shipToLocations) n)))))

(define (ship-to-uk-only items)
  (filter (λ (i)
             (foldr (λ (c acc) (or acc
                                   (string=? "GB" c)
                                   (string=? "UK" c)
                                   (string=? "Worldwide" c)))
                    #f (item-shipto i)))
          items))

(define (usd->gbp c)
  (* (string->number (getenv "USD_TO_GBP")) c))

(define (convert-currency items)
  (map (λ (item) (when (string=? "USD" (item-currency item))
                       (set-item-price! item (usd->gbp (item-price item)))
                       (set-item-currency! item "GBP"))
          item)
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
