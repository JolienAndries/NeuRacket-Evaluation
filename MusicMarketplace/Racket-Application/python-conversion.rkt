#lang racket

(provide (all-defined-out) run* run)
;; initialise pyffi
(require pyffi)
(initialize)
(post-initialize)

(define (python->scheme value)
  (cond ((pystring? value) (pystring->string value))
        ((pytuple? value) (vector-map python->scheme (pytuple->vector value)))
        ((pylist? value) (map python->scheme (pylist->list value)))
        (else value)))

(define (scheme->python value)
  (cond ((string? value) (string->pystring value))
        ((vector? value)  (vector->pytuple (vector-map scheme->python value)))
        ((list? value)  (list->pylist (map scheme->python value)))
        (else value)))