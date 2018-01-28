#lang racket

(require racket/gui/base)

(require (prefix-in m: "../model.rkt"))
(provide setup! 
         dispatch!)

(module+ test
  (require rackunit))

(define queue '())

(define (dispatch! f)
  (set! queue (cons f queue)))

(define (setup! initial-model model->nodes render!)
  (define loop 
    (lambda (model)
      (define model^ (foldl (lambda (fn acc) 
                              (fn acc)) model queue))
      (render! (model->nodes model^))

      (set! queue '())
      (sleep/yield 0.02)

      (loop model^)))

  (loop initial-model))

(module+ test
  )
