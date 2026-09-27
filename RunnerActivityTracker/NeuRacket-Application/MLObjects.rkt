#lang racket

(require mlobject (only-in racket/date current-date date->seconds))
(provide injury-prediction-model racetime-model training-intensity-model)



(define (calc-age bday)
  (let* ((current (current-date))
         (basic (- (date-year current) (date-year bday))))
    (if (or (< (date-month current) (date-month bday))
            (and (= (date-month current) (date-month bday))
                 (< (date-day current) (date-day bday))))
        (- basic 1)
        basic)))

(define (has-injury? injuries)
  (not (null? injuries)))

(define (get-intensity workouts)
  (if  (null? workouts)
       0
       (get-field perceived-intensity (car workouts))))

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
    (iter 1 (date->seconds (current-date)) 0 workouts)))

(define (get-duration workout)
  (get-field duration workout))

(define (get-risk injuries)
  ;; no injuries / all injuries recovered
  (if (andmap (lambda (injury) (get-field recovered? injury)) injuries)
      0
      1))
  
(define (seconds->minutes duration)
  (exact->inexact (/ duration 60)))

(define (calc-avg-elevation-diff workouts) (calc-avg-field (lambda (workout) (get-field elevation-difference workout)) workouts))
(define (calc-avg-duration workouts) (calc-avg-field (lambda (workout) (get-field duration workout)) workouts))
(define (calc-avg-distance workouts) (calc-avg-field (lambda (workout) (get-field distance workout)) workouts))
(define (calc-avg-speed workouts) (calc-avg-field (lambda (workout) (calc-speed (get-field duration workout) (get-field distance workout))) workouts))
  
(define (calc-avg-field field-getter workouts)
  (let ((ctr-sum (foldl (lambda (workout acc)
                          (let ((ctr (car acc))
                                (sum (cdr acc)))
                            (cons (+ ctr 1)
                                  (+ (field-getter workout) sum))))
                        (cons 0 0)
                        workouts)))

    (exact->inexact (/ (cdr ctr-sum) (car ctr-sum)))))

(define (calc-speed duration distance) ;; km/h
  (exact->inexact (/ distance (/ duration 3600))))

(defMLObject injury-prediction-model
  [file "../ML-components/injury_prediction/injury-model.py"]
  [infer "predict_injury"]
  [train "train_injury_prediction"]
  [input (calc-age birthday) weight height (has-injury? injuries) (get-intensity workouts)]
  [label (get-risk injuries)]
  [output predicted-risk])

(defMLObject racetime-model
  [file "../ML-components/marathon_prediction/marathon-prediction.py"]
  [infer "predict_time"]
  [train "train_marathon_time"]
  [input (get-dist-and-time race1) (get-dist-and-time race2) (avg-mileage-last-month workouts) (get-dist race)]
  [label (get-duration workout)]
  [guard (and race1 race2)]
  [output predicted-marathon-time])

(defMLObject training-intensity-model
  [file "../ML-components/training_intensity/training-intensity.py"]
  [infer "predict_training_intensity"]
  [train "train_training_intensity"]
  [input elevation-difference (seconds->minutes duration) distance (calc-speed duration distance) (calc-age bday)
         weight length (calc-avg-elevation-diff workouts) (calc-avg-duration workouts) (calc-avg-distance workouts)
         (calc-avg-speed workouts)]
  [label training-intensity])