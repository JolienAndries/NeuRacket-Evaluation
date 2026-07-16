#lang racket

(require "classes.rkt"
         "workout.rkt"
         racket/date)

(define user
  (new user%
       [name "Runner"]
       [password "secret"]
       [birthday (make-date 0 0 6 1 7 1989 0 0 #f 0)]
       [sex "V"]
       [weight 72]
       [height 178]))

(define sample-workout
  (new workout%
       [start-date (make-date 0 0 6 1 7 2026 0 0 #f 0)]
       [end-date (make-date 0 30 7 1 7 2026 0 0 #f 0)]
       [route (list (vector 50.0 4.3)
                    (vector 50.01 4.31)
                    (vector 50.02 4.32))]
       [max-elevation 120]
       [min-elevation 80]))

(define race
  (new race%
       [name "Race"]
       [place "Brussels"]
       [date (make-date 0 0 9 15 8 2026 0 0 #f 0)]
       [distance 10]
       [elevation-difference 50]))

(define user-race
  (new user-race% [race race]))

(define injury
  (new injury%
       [when (make-date 0 0 10 1 8 2026 0 0 #f 0)]
       [associated-workout sample-workout]
       [what "benchmark strain"]
       [body-part "leg"]
       [recovered? #f]))

(define (initialize!)
  (send user add-workout! sample-workout)
  (send user register user-race)
  (set-field! predicting-workout1 user-race sample-workout)
  (set-field! predicting-workout2 user-race sample-workout))
(initialize!)

(define (benchmark-training-intensity-get workout user x)
  (for ([i x])
    (send workout get-training-intensity user)))

(define (benchmark-training-intensity-set! workout user x)
  (for ([i x])
    (send workout set-training-intensity! 7 user)))

(define (benchmark-injury-get user x)
  (for ([i x])
    (send user get-injury-risk?)))

(define (benchmark-injury-set! user x)
  (for ([i x])
    (send user add-injury!
          (new injury%
               [when (make-date 0 0 10 1 8 2026 0 0 #f 0)]
               [associated-workout sample-workout]
               [what "benchmark injury"]
               [body-part "leg"]
               [recovered? #f]))))

(define (benchmark-racetime-get user-race user x)
  (for ([i x])
    (send user-race get-time-prediction user)))

(define (benchmark-racetime-set! user-race user x)
  (for ([i x])
    (send user-race set-time-prediction! user 3600)))

(define (do-benchmark-x-times count title benchmark)
  (displayln title)
  (for ([i count])
    (time (benchmark 100000)))) ;; 5 test / 100000 real

(define (run-benchmarks)
  (displayln "Running training intensity benchmark suite...")
  (do-benchmark-x-times 10 "Training intensity inference benchmark"
                        (lambda (x) (benchmark-training-intensity-get sample-workout user x)))
  (do-benchmark-x-times 10 "Training intensity training benchmark"
                        (lambda (x) (benchmark-training-intensity-set! sample-workout user x)))

  (displayln "Running injury prediction benchmark suite...")
  (do-benchmark-x-times 10 "Injury prediction inference benchmark"
                        (lambda (x) (benchmark-injury-get user x)))
  (do-benchmark-x-times 10 "Injury prediction training benchmark"
                        (lambda (x) (benchmark-injury-set! user x)))

  (displayln "Running race time benchmark suite...")
  (do-benchmark-x-times 10 "Race time inference benchmark"
                        (lambda (x) (benchmark-racetime-get user-race user x)))
  (do-benchmark-x-times 10 "Race time training benchmark"
                        (lambda (x) (benchmark-racetime-set! user-race user x))))

(run-benchmarks)

