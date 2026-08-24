#lang racket
(require racket/class "racket-classes.rkt")
(provide run-racket-inter-object-assign-benchmarks)
;; wat wil ik doen
;; ik wil assignen

;; 1 in 1 out

(define (assign-1-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%)))

    (displayln "(----- 1 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (do ((i 0 (+ i 1)))
                         ((>= i iter))
                         (set-field! external-neural obj 42)
                         (send obj train-neural-1-in-1-out obj-in)))))))
;; x in 1 out

(define (assign-3-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 3 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 3 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (do ((i 0 (+ i 1)))
                         ((>= i iter))
                         (set-field! external-neural obj 42)
                         (send/apply obj train-neural-3-in-1-out objs-in)))))))

(define (assign-5-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 5 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 5 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (do ((i 0 (+ i 1)))
                         ((>= i iter))
                         (set-field! external-neural obj 42)
                         (send/apply obj train-neural-5-in-1-out objs-in)))))))

(define (assign-7-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 7 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 7 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (do ((i 0 (+ i 1)))
                         ((>= i iter))
                         (set-field! external-neural obj 42)
                         (send/apply obj train-neural-7-in-1-out objs-in)))))))

(define (assign-9-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 9 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 9 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (do ((i 0 (+ i 1)))
                         ((>= i iter))
                         (set-field! external-neural obj 42)
                         (send/apply obj train-neural-9-in-1-out objs-in)))))))

(define (assign-11-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 11 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 11 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (do ((i 0 (+ i 1)))
                         ((>= i iter))
                         (set-field! external-neural obj 42)
                         (send/apply obj train-neural-11-in-1-out objs-in)))))))

(define (assign-13-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 13 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 13 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (do ((i 0 (+ i 1)))
                         ((>= i iter))
                         (set-field! external-neural obj 42)
                         (send/apply obj train-neural-13-in-1-out objs-in)))))))

(define (assign-15-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 15 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 15 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (do ((i 0 (+ i 1)))
                         ((>= i iter))
                         (set-field! external-neural obj 42)
                         (send/apply obj train-neural-15-in-1-out objs-in)))))))

(define (assign-17-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 17 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 17 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (do ((i 0 (+ i 1)))
                         ((>= i iter))
                         (set-field! external-neural obj 42)
                         (send/apply obj train-neural-17-in-1-out objs-in)))))))

(define (assign-19-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 19 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 19 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (do ((i 0 (+ i 1)))
                         ((>= i iter))
                         (set-field! external-neural obj 42)
                         (send/apply obj train-neural-19-in-1-out objs-in)))))))

;; 1 in y out
(define (assign-1-in-3-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 2 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 3 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln  (time (do ((i 0 (+ i 1)))
                          ((>= i iter))
                          (for-each (lambda (obj) (set-field! external-neural obj 42))
                                    (cons obj objs-out)))
                        (send/apply obj train-neural-3-in-1-out obj-in objs-out))))))

(define (assign-1-in-5-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 4 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 5 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln  (time (do ((i 0 (+ i 1)))
                          ((>= i iter))
                          (for-each (lambda (obj) (set-field! external-neural obj 42))
                                    (cons obj objs-out)))
                        (send/apply obj train-neural-5-in-1-out obj-in objs-out))))))

(define (assign-1-in-7-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 6 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 7 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln  (time (do ((i 0 (+ i 1)))
                          ((>= i iter))
                          (for-each (lambda (obj) (set-field! external-neural obj 42))
                                    (cons obj objs-out)))
                        (send/apply obj train-neural-7-in-1-out obj-in objs-out))))))

(define (assign-1-in-9-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 8 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 9 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln  (time (do ((i 0 (+ i 1)))
                          ((>= i iter))
                          (for-each (lambda (obj) (set-field! external-neural obj 42))
                                    (cons obj objs-out)))
                        (send/apply obj train-neural-9-in-1-out obj-in objs-out))))))

(define (assign-1-in-11-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 10 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 11 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln  (time (do ((i 0 (+ i 1)))
                          ((>= i iter))
                          (for-each (lambda (obj) (set-field! external-neural obj 42))
                                    (cons obj objs-out)))
                        (send/apply obj train-neural-11-in-1-out obj-in objs-out))))))

(define (assign-1-in-13-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 12 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 13 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln  (time (do ((i 0 (+ i 1)))
                          ((>= i iter))
                          (for-each (lambda (obj) (set-field! external-neural obj 42))
                                    (cons obj objs-out)))
                        (send/apply obj train-neural-13-in-1-out obj-in objs-out))))))

(define (assign-1-in-15-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 14 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 15 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln  (time (do ((i 0 (+ i 1)))
                          ((>= i iter))
                          (for-each (lambda (obj) (set-field! external-neural obj 42))
                                    (cons obj objs-out)))
                        (send/apply obj train-neural-15-in-1-out obj-in objs-out))))))

(define (assign-1-in-17-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 16 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 17 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln  (time (do ((i 0 (+ i 1)))
                          ((>= i iter))
                          (for-each (lambda (obj) (set-field! external-neural obj 42))
                                    (cons obj objs-out)))
                        (send/apply obj train-neural-17-in-1-out obj-in objs-out))))))

(define (assign-1-in-19-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 18 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 19 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln  (time (do ((i 0 (+ i 1)))
                          ((>= i iter))
                          (for-each (lambda (obj) (set-field! external-neural obj 42))
                                    (cons obj objs-out)))
                        (send/apply obj train-neural-19-in-1-out obj-in objs-out))))))

(define (run-racket-inter-object-assign-benchmarks iter times)
  (for-each (lambda (f) (f iter times))
            (list assign-1-in-1-out
                  assign-3-in-1-out
                  assign-5-in-1-out
                  assign-7-in-1-out
                  assign-9-in-1-out
                  assign-11-in-1-out
                  assign-13-in-1-out
                  assign-15-in-1-out
                  assign-17-in-1-out
                  assign-19-in-1-out
                  assign-1-in-3-out
                  assign-1-in-5-out
                  assign-1-in-7-out
                  assign-1-in-9-out
                  assign-1-in-11-out
                  assign-1-in-13-out
                  assign-1-in-15-out
                  assign-1-in-17-out
                  assign-1-in-19-out)))

