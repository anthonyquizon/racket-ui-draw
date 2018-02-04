#lang racket

(require racket/gui/base  
         racket/draw
         racket/match
         (prefix-in n: ui-draw/node))

(provide setup!
         render!)

(define canvas null)
(define frame null)
(define root null) 
(define initial-matrix null)
(define width 600)
(define height 480)

(define (setup! label handlers)
  (define on-keyboard (hash-ref handlers 'on-keyboard identity))

  (define main-canvas%
    (class canvas%
      (define/override (on-event event) null)
      (define/override (on-char event)
                       (on-keyboard (send event get-key-code)))
      (super-new)))
   
  (set! frame (new frame% 
                   [label label]
                   [width width]
                   [height height]))

  (set! canvas
    (new main-canvas% 
         [parent frame]
         [paint-callback on-paint]))

  (send frame show #t))

(define noEff '())

(define (path->drawEff dc path)
  (define p (new dc-path%))
  (define ops (n:path-ops path))

  (for-each 
    (lambda (op)
      (match op
        [(n:move x y) (send p move-to x y)]
        [(n:line x y) (send p line-to x y)]
        [(n:curve x1 y1 x2 y2 x3 y3) (send p curve-to x1 y1 x2 y2 x3 y3)]
        [_ noEff]))
    ops)
  
  (send dc draw-path p))

(define (arc->drawEff dc arc)
  (match-define (n:arc x y w h r0 r1) arc)
  (send dc draw-arc x y w h r0 r1))

(define (props->transform dc props)
  (for-each 
    (lambda (prop)
      (match prop
        [(n:scale x y) (send dc scale x y)]
        [(n:translate x y) (send dc translate x y)]
        [_ noEff]))
    props)

  (send dc get-transformation))

;(define (props->brush dc props)
  ;TODO
  ;(send dc get-brush))

(define (node->drawEff dc state node)
  (define props (n:node-props root)) 
  (define children (n:node-children root)) 

  ;(define transform (props->transform props))
  ;(define brush (props->brush props))

  (for ([child children])
    ;(send dc set-transformation)
    ;(send dc set-brush)

    (cond 
      [(n:path? child) (path->drawEff dc child)]
      [(n:arc? child) (arc->drawEff dc child)]
      [(n:node? child) (node->drawEff dc child)]
      [else noEff])))

(define (on-paint canvas dc)
  (if (equal? initial-matrix null)
    (set! initial-matrix (send dc get-initial-matrix))
    (send dc set-initial-matrix initial-matrix)) 

  (when (not (equal? root null))
    (node->drawEff dc '()  root)))

(define (render! root^)
  (set! root root^)
  (send frame refresh))

