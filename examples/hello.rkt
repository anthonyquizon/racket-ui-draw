#lang racket

(require (prefix-in d: ui-draw)
         (prefix-in n: ui-draw/node)
         (prefix-in r: ui-draw/reconciler)
         (prefix-in s: ui-draw/shape)
         racket/match)

(provide on-keyboard)

(struct Model (pos))
(define model (Model '(0 0 0)))

(define (vadd a b)
  (map + a b))

(define (on-keyboard key)
  (r:dispatch! 
    (lambda (model)
      (define pos (Model-pos model))
      (define pos^ 
        (match key
          ['left (vadd pos '(-1 0 0))]
          ['right (vadd pos '(1 0 0))]
          ['up (vadd pos '(0 -1 0))]
          ['down (vadd pos '(0 1 0))]
          ;;TODO quit
          [_ pos]))
      (struct-copy Model model [pos pos^]))))

(define handlers 
  (make-hash `((on-keyboard . ,on-keyboard))))

(define (model->nodes model)
  (match-define (list x y _) (Model-pos model))
  (n:node 
    '()  `(,(n:node 
              `(,(n:scale 2 2)) 
              `(,(s:circle (* x 10) (* y 10) 10))))))

(define (run!) 
  (d:run! #:label "hello"
          #:initial-model model
          #:model->nodes model->nodes
          #:handlers handlers))

(module+ main 
  (run!))
