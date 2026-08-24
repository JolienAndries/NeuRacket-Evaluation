#lang racket

(require "neuracket-classes.rkt" "neuracket-neural-slices.rkt")
(provide run-neuracket-inter-object-access-benchmarks)

(define (run-neuracket-inter-object-access-benchmarks iter times)
  (access-x-in-1-out iter times)
  (access-1-in-x-out iter times))

(define (access-x-in-1-out iter times)
  (for-each (lambda (neural-slice objs-in)
              (let ((obj-out (new inter-object-class%)))
                (apply new-neural-slice neural-slice (append objs-in (list obj-out)))
                (displayln (list "----- " (length objs-in) " in 1 out -----"))
                (do ((i 0 (+ i 1)))
                  ((>= i times))
                  (displayln (time (do-access (list obj-out) (list (lambda (obj) (get-field external-neural obj))) iter))))))
            (list 1-in-1-out-slice 3-in-1-out-slice 5-in-1-out-slice 7-in-1-out-slice
                  9-in-1-out-slice 11-in-1-out-slice 13-in-1-out-slice 15-in-1-out-slice
                  17-in-1-out-slice 19-in-1-out-slice)
            (build-list 10 (lambda (n)
                             (build-list (+ (* 2 n) 1) (lambda (_) (new inter-object-class%)))))))

(define (access-1-in-x-out iter times)
  (let ((get-field-functions (list (lambda (obj) (get-field external-neural obj))
                                   (lambda (obj) (get-field external-neural2 obj))
                                   (lambda (obj) (get-field external-neural3 obj))
                                   (lambda (obj) (get-field external-neural4 obj))
                                   (lambda (obj) (get-field external-neural5 obj))
                                   (lambda (obj) (get-field external-neural6 obj))
                                   (lambda (obj) (get-field external-neural7 obj))
                                   (lambda (obj) (get-field external-neural8 obj))
                                   (lambda (obj) (get-field external-neural9 obj))
                                   (lambda (obj) (get-field external-neural10 obj))
                                   (lambda (obj) (get-field external-neural11 obj))
                                   (lambda (obj) (get-field external-neural12 obj))
                                   (lambda (obj) (get-field external-neural13 obj))
                                   (lambda (obj) (get-field external-neural14 obj))
                                   (lambda (obj) (get-field external-neural15 obj))
                                   (lambda (obj) (get-field external-neural16 obj))
                                   (lambda (obj) (get-field external-neural17 obj))
                                   (lambda (obj) (get-field external-neural18 obj))
                                   (lambda (obj) (get-field external-neural19 obj)))))
    (for-each (lambda (neural-slice objs-out)
                (let ((obj-in (new inter-object-class%)))
                  (apply new-neural-slice neural-slice (cons obj-in objs-out))
                  (displayln (list "----- 1 in " (length objs-out) " out -----"))
                  (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
                    ((>= i times))
                    (displayln (time (do-access objs-out (take get-field-functions (length objs-out)) iter))))))
              (list 1-in-1-out-slice 1-in-3-out-slice 1-in-5-out-slice 1-in-7-out-slice
                    1-in-9-out-slice 1-in-11-out-slice 1-in-13-out-slice 1-in-15-out-slice
                    1-in-17-out-slice 1-in-19-out-slice)
              (build-list 10 (lambda (n)
                               (build-list (+ (* 2 n) 1) (lambda (_) (new inter-object-class%))))))))
  
    
    

(define (do-access objs funcs iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (for-each (lambda (function obj) (function obj))
              funcs objs)))



