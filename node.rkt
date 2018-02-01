#lang typed/racket

(module+ test
  (require rackunit))

(provide (all-defined-out))

(define-type Prop (U scale translate fill stroke))
(define-type Child (U node path))
(define-type Operation (U move line curve))
(define-type Unit Any)

(struct colour ([h : Real] 
                [s : Real] 
                [v : Real]))

(struct fill ([colour : colour]))
(struct stroke ([colour : colour]))
(struct scale ([x : Real] [y : Real]))
(struct translate ([x : Real] [y : Real]))

(struct move  ([x : Real] [y : Real]))
(struct line  ([x : Real] [y : Real]))
(struct curve  ([x1 : Real] [y1 : Real]
                [x2 : Real] [y2 : Real]
                [x3 : Real] [y3 : Real]))

(struct path ([ops : (Listof Operation)]))

(struct node ([props : (Listof Prop)]
              [children : (Listof Child)]))

(module+ test
  )
