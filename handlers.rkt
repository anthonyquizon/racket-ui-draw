#lang racket
;;#lang typed/racket

(require (prefix-in m: "../model.rkt")
         (prefix-in v: "../math/vector.rkt")
         (prefix-in r: "reconciler.rkt"))

(provide on-keyboard)

;(: on-keyboard (-> String ))
(define (on-keyboard key)
  (r:dispatch! 
    (lambda (model)
      (define pos (m:model-pos model))
      (define pos^ 
        (match key
          ['left (v:add pos '(-1 0 0))]
          ['right (v:add pos '(1 0 0))]
          ['up (v:add pos '(0 -1 0))]
          ['down (v:add pos '(0 1 0))]
          ;;TODO quit
          [_ pos]))
      (struct-copy m:model model [pos pos^]))))
