#lang at-exp racket
(require xml xml/path)
(require racket/port)
(require srfi/26)

(define input (port->string (open-input-file "input")))
(define input-wrapped
  (let ([t
          (regexp-replace* "<item>" input "<item-wrapper><item>")])
    (regexp-replace* #rx"</item>" t "</item></item-wrapper>")))

(define input-x (string->xexpr input-wrapped))

(define items (se-path*/list '(item-wrapper) input-x))

(struct item (title price location condition url))

(define (xml->item n)
  (apply item 
         (map (cut se-path* <> n) '((title) 
                                    (currentPrice) 
                                    (location) 
                                    (conditionDisplayName)
                                    (viewItemURL)))))

(map (λ (n)
        (define i (xml->item n))
        (displayln "########################################")
        (displayln (item-title i))
        (displayln (item-url i))
        (displayln "########################################")
        ) items)

