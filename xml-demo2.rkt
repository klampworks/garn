#lang at-exp racket
(require xml xml/path)
(require racket/port)

(define input (port->string (open-input-file "input")))
(define input-wrapped
  (let ([t
          (regexp-replace* "<item>" input "<item-wrapper><item>")])
    (regexp-replace* #rx"</item>" t "</item></item-wrapper>")))

(define input-x (string->xexpr input-wrapped))

(define items (se-path*/list '(item-wrapper) input-x))

(map (λ (n)
        (define title (se-path* '(title) n))
        (define price (se-path* '(currentPrice) n))
        (define loc (se-path* '(location) n))
        (define con (se-path* '(conditionDisplayName) n))
        (displayln "########################################")
;        (displayln n)
        (when (and title price)
          (printf "Title: ~a~nPrice: ~a~nLocation: ~a~nCondition: ~a~n"
                  title price loc con))
        (displayln "########################################")
        ) items)

