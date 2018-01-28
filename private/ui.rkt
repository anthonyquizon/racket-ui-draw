#lang racket

(require racket/gui/base  
         racket/draw
         racket/match
         (prefix-in n: "../nodes.rkt"))

(provide setup!
         render!)

(define canvas null)
(define frame null)
(define root null) 
(define initial-matrix null)
(define width 600)
(define height 480)

(define (setup! on-keyboard)
  (define main-canvas%
    (class canvas%
      (define/override (on-event event) null)
      (define/override (on-char event)
                       (on-keyboard (send event get-key-code)))
      (super-new)))
   
  (set! frame (new frame% 
                   [label "Illustrations and Diagrams"]
                   [width width]
                   [height height]))

  (set! canvas
    (new main-canvas% 
         [parent frame]
         [paint-callback on-paint]))

  (send frame show #t))

(define noEff '())

(define (point->drawEff dc point)
  (define w/2 10)
  (define h/2 10)
  (send dc draw-rectangle 
        (- (n:point-x point) w/2) 
        (- (n:point-y point) h/2)
        w/2
        h/2))

(define (line->drawEff dc line)
  noEff)

(define (scale->drawEff dc s)
  (send dc scale (n:scale-x s) (n:scale-y s)))

(define (translate->drawEff dc s)
  (send dc translate (n:translate-x s) (n:translate-y s)))

(define (node->drawEff dc node)
  (define props (n:node-props root)) 
  (define children (n:node-children root)) 

  (for ([prop props])
    (cond
      [(n:scale? prop) (scale->drawEff dc prop)]
      [(n:translate? prop) (translate->drawEff dc prop)]
      [else noEff]))

  (for ([child children])
    (cond 
      [(n:point? child) (point->drawEff dc child)]
      [(n:line? child) (line->drawEff dc child)]
      [else noEff])))

(define (on-paint canvas dc)
  (if (equal? initial-matrix null)
    (set! initial-matrix (send dc get-initial-matrix))
    (send dc set-initial-matrix initial-matrix)) 

  (when (not (equal? root null))
    (node->drawEff dc root)))

(define (render! root^)
  (set! root root^)
  (send frame refresh))

