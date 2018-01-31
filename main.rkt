#lang racket

(require (prefix-in ui: "./private/ui.rkt")
         (prefix-in r: "./reconciler.rkt"))

(provide run!)

(define (run! #:label label
              #:initial-model initial-model 
              #:model->nodes model->nodes 
              #:handlers handlers)
  (ui:setup! label handlers)
  (r:setup!
    initial-model
    model->nodes
    ui:render!))

