#lang typed/racket

(module+ test
  (require rackunit))

(provide (all-defined-out))

(define-type Prop (U scale translate fill stroke))
(define-type Child (U node arc line path))
(define-type PathOperation (U moveTo lineTo curveTo))
(define-type Unit Any)

(struct colour ([h : Real] 
                [s : Real] 
                [v : Real]))

(struct fill ([colour : colour]))
(struct stroke ([colour : colour]))
(struct scale ([x : Real] [y : Real]))
(struct translate ([x : Real] [y : Real]))

(struct moveTo ([x : Real] [y : Real]))
(struct lineTo ([x : Real] [y : Real]))
(struct curveTo  ([x0 : Real] [y0 : Real]
                  [x1 : Real] [y1 : Real]
                  [x2 : Real] [y2 : Real]))

(struct path ([ops : (Listof PathOperation)]))

(struct arc ([x : Real] [y : Real] 
             [width : Real] [height : Real]
             [start-radian : Real] [end-radian : Real]))

(struct line ([x0 : Real] [y0 : Real] 
              [x1 : Real] [y1 : Real])) 

(struct node ([props : (Listof Prop)]
              [children : (Listof Child)]))


(module+ test
  )
