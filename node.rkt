#lang typed/racket

(module+ test
  (require rackunit))

(provide (all-defined-out))

(define-type Prop (U scale translate fill stroke))
(define-type Child (U node point line curve))
(define-type Unit Any)

(struct colour ([h : Real] 
                [s : Real] 
                [v : Real]))

(struct fill ([colour : colour]))
(struct stroke ([colour : colour]))
(struct scale ([x : Real] [y : Real]))
(struct translate ([x : Real] [y : Real]))

(struct point ([x : Real] [y : Real]))
(struct line  ([point : (Listof point)]))
(struct curve ([a : point] [b : point] [c : point]))

(struct node ([props : (Listof Prop)]
              [children : (Listof Child)]))

(module+ test
  )
