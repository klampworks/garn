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

(struct item (title price location condition))

(define (xml->item n)
  (apply item 
         (map (cut se-path* <> n) '((title) 
                                    (currentPrice) 
                                    (location) 
                                    (conditionDisplayName)))))

(map (λ (n)
        (define i (xml->item n))
            ;(se-path* '(title) n)
            ;(se-path* '(currentPrice) n)
            ;(se-path* '(location) n)
            ;(se-path* '(conditionDisplayName) n)))
        (displayln "########################################")
        (displayln (item-title i))
;        (when (and title price)
;          (printf "Title: ~a~nPrice: ~a~nLocation: ~a~nCondition: ~a~n"
;                  title price loc con))
        (displayln "########################################")
        ) items)

