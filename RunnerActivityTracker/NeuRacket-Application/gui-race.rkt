#lang racket/base

(provide add-race-panel view-races-panel)
(require racket/gui "gui-helpers.rkt" map-widget (only-in "classes.rkt" race% user-race%))


(define (add-race-panel parent add-event)
  (let ((top (new vertical-panel% [parent parent])))

    (let ((name (new text-field% [parent top] [label "Name: "]))
          (date (new date-time-input% [parent top] [label "When: "] [max-year 2030]))
          (place (new text-field% [parent top] [label "Where: "]))
          (distance (new text-field% [parent top] [label "Distance: "]))
          (elevation-difference (new text-field% [parent top] [label "Elevation: "])))

      (new button% [parent top]
           [label "Add"]
           [callback (lambda (btn evt)
                       (let ((race (new race%
                                        [name (send name get-value)]
                                        [place (send place get-value)]
                                        [date (send date get-value)]
                                        [distance (string->number (send distance get-value))]
                                        [elevation-difference (string->number (send elevation-difference get-value))])))
                         (add-event race)
                         (view-single-race-panel top race)))])
      top)))

(define (view-single-race-panel parent race [register-user #f])
  (let* ((top (new horizontal-panel%
                   [parent parent]
                   [min-height 300]
                   [stretchable-height #f]))
         (info (new vertical-panel%
                    [parent top])))
    ;; refresh view
    (define (refresh)
      (send parent delete-child top)
      (view-single-race-panel parent race register-user))
    
    ;; show information
    (new show-horizontal-value% [parent info]
         [label "name: "]
         [value (get-field name race)])
    (new show-date% [parent info]
         [label "when: "]
         [date (get-field date race)])
    (new show-horizontal-value% [parent info]
         [label "where: "]
         [value (get-field place race)])
    (new show-horizontal-value% [parent info]
         [label "distance: "]
         [value (number->string  (get-field distance race))])
    (new show-horizontal-value% [parent info]
         [label "total elevation: "]
         [value (number->string (get-field elevation-difference race))])

    (when register-user
      (let ((register-panel (new vertical-panel% [parent top]))
            (user-race (send register-user registered-race race)))
        (if user-race
            (let ((assoc-workout (get-field workout user-race))
                  (workouts (get-field workouts register-user)))
              (define (choose-workout label callback-func)
                (new custom-choice%
                     [parent register-panel]
                     [label label]
                     [choices (cons "none"
                                    (map (lambda (w)
                                           (date->string (get-field start-date w)))
                                         workouts))]
                     [real-ones (cons #f workouts)]
                     [init "none"]
                     [callback callback-func]))
              (if assoc-workout
                  (let ((map (new map-widget% [parent register-panel])))
    
                    ;; draw route on map
                    (send map add-layer (line-layer 'TODO-workout (get-field route assoc-workout)))
                    (send map zoom-level 13)
                    (send map move-to (car (get-field route assoc-workout))))
                  
                  (begin
                    (choose-workout "Couple workout: " (lambda (c evt)
                                                         (let ((assoc-workout (send c get-value)))
                                                           (when assoc-workout
                                                             (send user-race assoc-workout! assoc-workout)
                                                             (send register-user race-run! user-race)
                                                             (refresh)))))
                    (new button%
                         [parent register-panel]
                         [label "Deregister"]
                         [callback (lambda (btn evt)
                                     (send race deregister register-user)
                                     (send register-user deregister user-race)
                                     (refresh))])
                    
                    (new message% [parent register-panel]
                         [label (let ((race1 (get-field predicting-workout1 user-race))
                                      (race2 (get-field predicting-workout2 user-race)))
                                  (if (and race1 race2)
                                      (let* ((t  (get-field time-prediction user-race))
                                             (t-floor (floor t)))
                                        (string-append "Based on the selected workouts, your predicted time will be: " (number->string t-floor) "h" (number->string (floor (* 60 (- t t-floor)))) "m" "\nYou can change the selected workouts"))
                                      "Select workouts to predict:"))])
                    (choose-workout "Couple the first workout: " (lambda (c evt)
                                                                   (let ((workout (send c get-value)))
                                                                     (when  workout
                                                                       (set-field! predicting-workout1 user-race workout)))))
                    (choose-workout "Couple the second workout: " (lambda (c evt)
                                                                    (let ((workout (send c get-value)))
                                                                      (when  workout
                                                                        (set-field! predicting-workout2 user-race workout)))))
                    (new button%
                         [parent register-panel]
                         [label "Chosen!"]
                         [callback (lambda (btn evt) (refresh))]))))
            (new button% [parent register-panel]
                 [label "Register"] 
                 [callback (lambda (btn evt)
                             (send race register register-user)
                             (send register-user register (new user-race% [race race]))
                             (refresh))]))))

    top))


(define (view-races-panel parent races logged-in-user)
  (view-panel parent
              (lambda (race) (date->string (get-field date race)))
              races
              (lambda (parent race) (view-single-race-panel parent race logged-in-user))))