#lang racket

(require "intra-object-access-benchmarks.rkt" "neuracket-classes.rkt" "neuracket-intra-object-assign-benchmarks.rkt"
         "neuracket-inter-object-access-benchmark.rkt" "neuracket-inter-object-assign-benchmark.rkt")

(define (run-benchmarks iter times)
  (displayln "*****************************************")
  (displayln "********** intra-object access **********")
  (displayln "*****************************************")
  (run-access-benchmark iter times intra-object-1-out intra-object-1-in)
  (displayln "*****************************************")
  (displayln "********** intra-object assign **********")
  (displayln "*****************************************")
  (do-assign-benchmark iter times intra-object-1-out intra-object-1-in)
  (displayln "*****************************************")
  (displayln "********** inter-object access **********")
  (displayln "*****************************************")
  (run-neuracket-inter-object-access-benchmarks iter times)
  (displayln "*****************************************")
  (displayln "********** inter-object assign **********")
  (displayln "*****************************************")
  (run-neuracket-inter-object-assign-benchmarks iter times))


(define (test-benchmarks) (run-benchmarks 1 1))
(define (real-benchmarks) (run-benchmarks 10000 15))

(test-benchmarks)
;; (real-benchmarks)