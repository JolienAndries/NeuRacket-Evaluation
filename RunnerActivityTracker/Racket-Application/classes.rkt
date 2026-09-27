#lang racket

(require (only-in "MLObjects.rkt" injury-prediction-model racetime-model))
(provide user% race% injury% user-race%)

(define user% (class object%
                (init-field name sex
                            [races-run '()]
                            [upcoming-races '()]
                            [injuries '()]
                            [workouts '()]
                            [injury-risk? #f])

                (define password #f)
                (field [birthday #f]
                       [weight #f]
                       [height #f])

                (define/public (add-personal-information! new-password new-birthday new-weight new-height)
                  (set! password new-password)
                  (set! birthday new-birthday)
                  (set! weight new-weight)
                  (set! height new-height))

                (define/public (correct-password? other-password)
                  (equal? other-password password))
               
                (define/public (get-injury-risk?)
                  (let ((res (send injury-prediction-model infer birthday weight height injuries workouts)))
                    (set! injury-risk? res)
                    res))
                
                (define/public (set-injury-risk! new-risk)
                  (set! injury-risk? new-risk)
                  (send injury-prediction-model train injury-risk? birthday weight height injuries workouts))
                
                (define/public (add-workout! workout)
                  (set! workouts (cons workout workouts)))

                (define/public (registered-race race)
                  (define (same-race? r1 ur2)
                    (let ((r2 (get-field race ur2)))
                      (equal? r1 r2)))
                    
                  (let ((race-found? (or (member race races-run same-race?) (member race upcoming-races same-race?))))
                    (if race-found? (car race-found?) race-found?)))
                
                (define/public (add-injury! injury)
                  (set-injury-risk! 1)
                  (set! injuries (cons injury injuries)))
                
                (define/public (race-run! race)
                  (set! upcoming-races (remove race upcoming-races))
                  (set! races-run (cons race races-run)))

                (define/public (register race)
                  (set! upcoming-races (cons race upcoming-races)))

                (define/public (deregister race)
                  (set! upcoming-races (remove race upcoming-races)))
              
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
                     (init-field race [predicting-workout1 #f] [predicting-workout2 #f] [run? #f])
                     (field [time-prediction #f])

                     (define/public (get-time-prediction user)
                       (let ((res (send racetime-model infer predicting-workout1 predicting-workout2 (get-field workouts user) race)))
                         (set! time-prediction res)
                         res))
                     
                     (define/public (set-time-prediction! user new-prediction)
                       (set! time-prediction new-prediction)
                       (send racetime-model train time-prediction predicting-workout1 predicting-workout2 (get-field workouts user) race))
                       
                     (define/public (assoc-workout! workout user)
                       (unless run?
                         (when (and predicting-workout1 predicting-workout2) (set-time-prediction! user (get-field duration workout)))
                         (set-field! run? this workout)))
                     
                     (super-new)))

(define race% (class object%
                (init-field name place date distance elevation-difference [participants '()])
                (define/public (register user)
                  (set! participants (cons user participants)))
                (define/public (deregister user)
                  (set! participants (remove user participants)))
                (super-new)))