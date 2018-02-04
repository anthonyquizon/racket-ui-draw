#lang racket

(require (prefix-in n: ui-draw/node))

(provide circle)

(define (circle x y r) 
  (n:arc x y r r 0 (* 2 pi)))
