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

(define xml-items (map xml->item items))

(for ([n xml-items])
        (displayln "########################################")
        (displayln (item-title n))
        (displayln (item-url n))
        (displayln "########################################"))
