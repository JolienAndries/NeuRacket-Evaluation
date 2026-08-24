#lang racket/base
(require racket/class "racket-classes.rkt")
(provide run-racket-inter-object-access-benchmarks)
;; wat wil ik doen
;; de tijd meten om te accessen van inter-object


;; 1 in 1 out 
(define (access-1-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%)))

    (displayln "(----- 1 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send obj infer-neural-1-in-1-out obj-in)
                         (do-access (list obj) times)))))))

;; x in 1 out
(define (access-3-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 3 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 3 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-3-in-1-out objs-in)
                         (do-access (list obj) iter)))))))

(define (access-5-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 5 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 5 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-5-in-1-out objs-in)
                         (do-access (list obj) iter)))))))

(define (access-7-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 7 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 7 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-7-in-1-out objs-in)
                         (do-access (list obj) iter)))))))


(define (access-9-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 9 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 9 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-9-in-1-out objs-in)
                         (do-access (list obj) iter)))))))


(define (access-11-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 11 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 11 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-11-in-1-out objs-in)
                         (do-access (list obj) iter)))))))


(define (access-13-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 13 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 13 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-13-in-1-out objs-in)
                         (do-access (list obj) iter)))))))

(define (access-15-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 15 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 15 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-15-in-1-out objs-in)
                         (do-access (list obj) iter)))))))

(define (access-17-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 17 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 17 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-17-in-1-out objs-in)
                         (do-access (list obj) iter)))))))

(define (access-19-in-1-out iter times)
  (let ((obj (new inter-object-class%))
        (objs-in (build-list 19 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 19 in 1 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-19-in-1-out objs-in)
                         (do-access (list obj) iter)))))))



;; 1 in y out
(define (access-1-in-3-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 2 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 3 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-1-in-3-out! obj-in objs-out)
                         (do-access (cons obj objs-out) iter)))))))

(define (access-1-in-5-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 4 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 5 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-1-in-5-out! obj-in objs-out)
                         (do-access (cons obj objs-out) iter)))))))

(define (access-1-in-7-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 6 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 7 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-1-in-7-out! obj-in objs-out)
                         (do-access (cons obj objs-out) iter)))))))

(define (access-1-in-9-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 8 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 9 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-1-in-9-out! obj-in objs-out)
                         (do-access (cons obj objs-out) iter)))))))

(define (access-1-in-11-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 10 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 11 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-1-in-11-out! obj-in objs-out)
                         (do-access (cons obj objs-out) iter)))))))

(define (access-1-in-13-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 12 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 13 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-1-in-13-out! obj-in objs-out)
                         (do-access (cons obj objs-out) iter)))))))

(define (access-1-in-15-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 14 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 15 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-1-in-15-out! obj-in objs-out)
                         (do-access (cons obj objs-out) iter)))))))

(define (access-1-in-17-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 16 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 17 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-1-in-17-out! obj-in objs-out)
                         (do-access (cons obj objs-out) iter)))))))

(define (access-1-in-19-out iter times)
  (let ((obj (new inter-object-class%))
        (obj-in (new inter-object-class%))
        (objs-out (build-list 18 (lambda (_) (new inter-object-class%)))))
    (displayln "(----- 1 in 19 out -----)")
    (do ((i 0 (+ i 1))) ;; do benchmark 10 times 
      ((>= i times))
      (displayln (time (begin 
                         (send/apply obj infer-neural-1-in-19-out! obj-in objs-out)
                         (do-access (cons obj objs-out) iter)))))))

(define (do-access objs iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (for-each
     (lambda (obj)
       (get-field external-neural obj))
     objs)))


(define (run-racket-inter-object-access-benchmarks iter times)
  (for-each (lambda (f) (f iter times))
            (list
             ;; 1 in 1 out
             access-1-in-1-out
             ;; x in 1 out
             access-3-in-1-out
             access-5-in-1-out
             access-7-in-1-out
             access-9-in-1-out
             access-11-in-1-out
             access-13-in-1-out
             access-15-in-1-out
             access-17-in-1-out
             access-19-in-1-out
             ;; 1 in y out
             access-1-in-3-out
             access-1-in-5-out
             access-1-in-7-out
             access-1-in-9-out
             access-1-in-11-out
             access-1-in-13-out
             access-1-in-15-out
             access-1-in-17-out
             access-1-in-19-out)))