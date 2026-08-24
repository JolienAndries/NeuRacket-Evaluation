#lang racket
(provide do-assign-benchmark)
;; 1-out 
(define (benchmark-assign-1-in-1-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-field! lbl1 obj 42)))

(define (benchmark-assign-3-in-1-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-field! lbl3 obj 42)))

(define (benchmark-assign-5-in-1-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-field! lbl5 obj 42)))

(define (benchmark-assign-7-in-1-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-field! lbl7 obj 42)))

(define (benchmark-assign-9-in-1-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-field! lbl9 obj 42)))

(define (benchmark-assign-11-in-1-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-field! lbl11 obj 42)))

(define (benchmark-assign-13-in-1-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-field! lbl13 obj 42)))

(define (benchmark-assign-15-in-1-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-field! lbl15 obj 42)))

(define (benchmark-assign-17-in-1-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-field! lbl17 obj 42)))

(define (benchmark-assign-19-in-1-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-field! lbl19 obj 42)))

;; 1-in

(define (benchmark-assign-1-in-3-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-fields! (lbl3.1 lbl3.2 lbl3.3) obj (1 2 3))))

(define (benchmark-assign-1-in-5-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-fields! (lbl5.1 lbl5.2 lbl5.3 lbl5.4 lbl5.5) obj (1 2 3 4 5))))

(define (benchmark-assign-1-in-7-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-fields! (lbl7.1 lbl7.2 lbl7.3 lbl7.4 lbl7.5 lbl7.6 lbl7.7) obj (1 2 3 4 5 6 7))))

(define (benchmark-assign-1-in-9-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-fields! (lbl9.1 lbl9.2 lbl9.3 lbl9.4 lbl9.5 lbl9.6 lbl9.7 lbl9.8 lbl9.9) obj (1 2 3 4 5 6 7 8 9))))

(define (benchmark-assign-1-in-11-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-fields! (lbl11.1 lbl11.2 lbl11.3 lbl11.4 lbl11.5 lbl11.6 lbl11.7 lbl11.8 lbl11.9 lbl11.10 lbl11.11) obj  (1 2 3 4 5 6 7 8 9 10 11))))

(define (benchmark-assign-1-in-13-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-fields!
     (lbl13.1 lbl13.2 lbl13.3 lbl13.4 lbl13.5 lbl13.6 lbl13.7 lbl13.8 lbl13.9 lbl13.10 lbl13.11 lbl13.12 lbl13.13)
     obj
     (1 2 3 4 5 6 7 8 9 10 11 12 13))))

(define (benchmark-assign-1-in-15-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-fields!
     (lbl15.1 lbl15.2 lbl15.3 lbl15.4 lbl15.5 lbl15.6 lbl15.7 lbl15.8 lbl15.9 lbl15.10 lbl15.11 lbl15.12 lbl15.13 lbl15.14 lbl15.15)
     obj
     (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))))

(define (benchmark-assign-1-in-17-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-fields!
     (lbl17.1 lbl17.2 lbl17.3 lbl17.4 lbl17.5 lbl17.6 lbl17.7 lbl17.8 lbl17.9 lbl17.10 lbl17.11 lbl17.12 lbl17.13 lbl17.14 lbl17.15 lbl17.16 lbl17.17)
     obj
     (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17))))

(define (benchmark-assign-1-in-19-out obj iter)
  (do ((i 0 (+ i 1)))
    ((>= i iter))
    (set-fields!
     (lbl19.1 lbl19.2 lbl19.3 lbl19.4 lbl19.5 lbl19.6 lbl19.7 lbl19.8 lbl19.9 lbl19.10 lbl19.11 lbl19.12 lbl19.13 lbl19.14 lbl19.15 lbl19.16 lbl19.17 lbl19.18 lbl19.19)
     obj
     (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19))))

(define (do-benchmark-x-times iter times obj benchmark title)
  (displayln title)
  (do ((i 0 (+ i 1)))
    ((>= i times))
    (displayln (time (benchmark obj iter)))))

(define (do-assign-benchmark iter times object-1-out object-1-in)
  (for-each (lambda (b title) (do-benchmark-x-times iter times object-1-out b title))
            (list benchmark-assign-1-in-1-out benchmark-assign-3-in-1-out benchmark-assign-5-in-1-out benchmark-assign-7-in-1-out benchmark-assign-9-in-1-out benchmark-assign-11-in-1-out benchmark-assign-13-in-1-out benchmark-assign-15-in-1-out benchmark-assign-17-in-1-out benchmark-assign-19-in-1-out)
            (build-list 10 (lambda (n) (list "-----" (+ (* 2 n) 1) "in 1 out -----"))))
  (for-each (lambda (b title) (do-benchmark-x-times iter times object-1-in b title))
            (list benchmark-assign-1-in-3-out benchmark-assign-1-in-5-out benchmark-assign-1-in-7-out benchmark-assign-1-in-9-out benchmark-assign-1-in-11-out benchmark-assign-1-in-13-out benchmark-assign-1-in-15-out benchmark-assign-1-in-17-out benchmark-assign-1-in-19-out)
            (build-list 9 (lambda (n) (list "----- 1 in " (+ (* 2 n) 3) "out -----")))))
       
