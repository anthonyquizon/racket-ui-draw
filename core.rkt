#lang racket

(require (prefix-in ui: "./ui.rkt")
         (prefix-in r: "./reconciler.rkt"))

(provide run!)

(define (run! init-model model->nodes handlers)
  (ui:setup! handlers)
  (r:setup!
    init-model
    model->nodes
    ui:render!))

