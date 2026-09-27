#lang racket

(require (only-in "MLObjects.rkt" injury-prediction-model) (only-in "neural-slices.rkt" marathon-time-prediction-slice))
(provide user% race% injury% user-race%)

(define user% (class object%
                (init-field name sex
                            [races-run '()]
                            [upcoming-races '()]
                            [workouts '()])
                (label-field [injuries '()])
                (neural-field [(injury-risk?) injury-prediction-model (birthday weight height injuries workouts) (injuries)])

                (define password #f)
                (define birthday #f)
                (define weight #f)
                (define height #f)

                (define/public (add-personal-information! new-password new-birthday new-weight new-height)
                  (set! password new-password)
                  (set! birthday new-birthday)
                  (set! weight new-weight)
                  (set! height new-height))

                (define/public (correct-password? other-password)
                  (equal? other-password password))
                
                
                (define/public (add-workout! workout)
                  (set-field! workouts this (cons workout workouts)))

                (define/public (registered-race race)
                  (define (same-race? r1 ur2)
                    (let ((r2 (get-field race ur2)))
                      (equal? r1 r2)))
                    
                  (let ((race-found? (or (member race races-run same-race?) (member race upcoming-races same-race?))))
                    (if race-found? (car race-found?) race-found?)))
                
                (define/public (add-injury! injury)
                  (set-field! injuries this (cons injury (get-field injuries this))))
                
                (define/public (race-run! race)
                  (set-field! upcoming-races this (remove race upcoming-races))
                  (set-field! races-run this (cons race races-run)))

                (define/public (register race)
                  (new-neural-slice marathon-time-prediction-slice this race)
                  (set-field! upcoming-races this (cons race upcoming-races)))

                (define/public (deregister race)
                  (set-field! upcoming-races this (remove race upcoming-races)))
              
                (super-new)))

(define injury% (class object%
                  (init-field
                   when
                   associated-workout
                   what
                   body-part
                   recovered?)                  
                  (super-new)))

(define user-race% (class object%
                     (init-field race [predicting-workout1 #f] [predicting-workout2 #f])
                     (label-field [workout #f])
                     (external-neural-field time-prediction)
                     (define/public (assoc-workout! new-workout)
                       (set-field! workout this new-workout))
                     (super-new)))

(define race% (class object%
                (init-field name place date distance elevation-difference [participants '()])
                (define/public (register user)
                  (set! participants (cons user participants)))
                (define/public (deregister user)
                  (set! participants (remove user participants)))
                (super-new)))

