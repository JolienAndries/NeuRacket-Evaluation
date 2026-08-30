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

;;;;;;;;;;;;;;;;;;;;;;;;

(define (benchmark-training-intensity-get workout x)
  (for ([i x])
    (get-field training-intensity workout)))

(define (benchmark-training-intensity-set workout x)
  (for ([i x])
    (set-field! perceived-intensity workout 7)))

(define (benchmark-injury-get user x)
  (for ([i x])
    (get-field injury-risk? user)))

(define (benchmark-injury-set! user x)
  (for ([i x])
    (send user add-injury!
          (new injury%
               [when (make-date 0 0 10 1 8 2026 0 0 #f 0)]
               [associated-workout sample-workout]
               [what "benchmark injury"]
               [body-part "leg"]
               [recovered? #f]))))

(define (benchmark-racetime-get user-race x)
  (for ([i x])
    (get-field time-prediction user-race)))

(define (benchmark-racetime-set! user-race x)
  (for ([i x])
    (set-field! workout user-race sample-workout)))

(define (do-benchmark-x-times x times obj benchmark title)
  (displayln title)
  (do ((i 0 (+ i 1)))
    ((>= i times))
    (displayln (time (benchmark obj x))))) ;; 5 testen / 100000 real

;;;;;;;;;;;;;;;;;;;;;;;;

(define (run-benchmarks x times)
  (displayln "Running training intensity benchmark suite...")
  (do-benchmark-x-times x times sample-workout benchmark-training-intensity-get "Training intensity inference benchmark")
  (do-benchmark-x-times x times sample-workout benchmark-training-intensity-set "Training intensity training benchmark")

  (displayln "Running injury prediction benchmark suite...")
  (do-benchmark-x-times x times user benchmark-injury-get "Injury prediction inference benchmark")
  (do-benchmark-x-times x times user benchmark-injury-set! "Injury prediction training benchmark")

  (displayln "Running race time benchmark suite...")
  (do-benchmark-x-times x times user-race benchmark-racetime-get "Race time inference benchmark")
  (do-benchmark-x-times x times user-race benchmark-racetime-set! "Race time training benchmark"))

(run-benchmarks 1 1)
(run-benchmarks 10 15)

