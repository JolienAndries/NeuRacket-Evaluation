#lang racket

(require (only-in racket/date current-date date->seconds))
(provide injury-prediction-model racetime-model)
;; initialise pyffi
(require pyffi)
(initialize)
(post-initialize)

(define (python->racket value)
  (cond ((pystring? value) (pystring->string value))
        ((pytuple? value) (vector-map python->racket (pytuple->vector value)))
        ((pylist? value) (map python->racket (pylist->list value)))
        ((pydict? value) (hash-map/copy (pydict->hash value) (lambda (k v) (values (python->racket k) (python->racket v)))))
        (else value)))

(define (racket->python value)
  (cond ((string? value) (string->pystring value))
        ((vector? value)  (vector->pytuple (vector-map racket->python value)))
        ((list? value)  (list->pylist (map racket->python value)))
        ((hash? value) (hash->pydict (hash-map/copy value (lambda (k v) (values (racket->python k) (racket->python v))))))
        (else value)))

(define (output->values output)
  (cond ((vector? output) (vector->values output))
        ((list? output) (vector->values (list->vector output)))
        (else output)))


(define (calc-age bday)
  (let* ((current (current-date))
         (basic (- (date-year current) (date-year bday))))
    (if (or (< (date-month current) (date-month bday))
            (and (= (date-month current) (date-month bday))
                 (< (date-day current) (date-day bday))))
        (- basic 1)
        basic)))

(define injury-prediction-model (new (class object%
                                       (run* "with open('../ML-components/injury_prediction/injury-model.py') as file: exec(file.read())")
                                       (define python-train (run "train_injury_prediction"))
                                       (define python-infer (run "predict_injury"))

                                       (define/public (train injury-risk birthday weight height injuries workouts)
                                         (apply python-train (map racket->python (list injury-risk  (calc-age birthday) weight height (has-injury? injuries) (get-intensity workouts)))))

                                       (define/public (infer birthday weight height injuries workouts)
                                         (python->racket (apply python-infer (map racket->python (list  (calc-age birthday) weight height (has-injury? injuries) (get-intensity workouts))))))
  
                                       (define (has-injury? injuries)
                                         (not (null? injuries)))

                                       (define (get-intensity workouts)
                                         (if  (null? workouts)
                                              0
                                              (get-field intensity (car workouts))))
                                       (super-new))))

(define racetime-model (new (class object% (super-new)
                              (run* "with open('../ML-components/marathon_prediction/marathon-prediction.py') as file: exec(file.read())")
                              (define python-train (run "train_marathon_time"))
                              (define python-infer (run "predict_time"))

                              (define/public (train marathon-time race1 race2 workouts race)
                                (apply python-train (map racket->python (list marathon-time (get-dist-and-time race1) (get-dist-and-time race2) (avg-mileage-last-month workouts) (get-dist race)))))

                              (define/public (infer race1 race2 workouts race)
                               (vector->values (python->racket (apply python-infer (map racket->python (list (get-dist-and-time race1) (get-dist-and-time race2) (avg-mileage-last-month workouts) (get-dist race)))))))
  
                              (define (get-dist race)
                                (get-field distance race))
                              (define (get-dist-and-time race)
                                (list (get-field distance race) (get-field duration race)))
  
                              ;; bereken de avg mileage vd laatste 4 weken
                              (define (avg-mileage-last-month workouts) ;; assumes sorted workouts by date, latest date first 
                                (let ((7days (* 7 24 60 60)))
                                  (define (in-last-week? date1-s date2-s)
                                    (<= 0 (- date1-s date2-s) 7days))
                                  (define (iter week date mileage workouts)
                                    (cond ((null? workouts) (/ mileage 4))
                                          ((in-last-week? date (date->seconds (get-field start-date (car workouts))))
                                           (iter week date (+ mileage (get-field distance (car workouts))) (cdr workouts)))
                                          ((< week 4) (iter (+ week 1) (- date 7days) mileage workouts))
                                          (else (/ mileage 4))))
                                  (iter 1 (date->seconds (current-date)) 0 workouts))))))



