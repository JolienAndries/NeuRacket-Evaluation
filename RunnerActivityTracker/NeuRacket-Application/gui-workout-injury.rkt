#lang racket

(provide add-workout-panel view-workouts-panel add-injury-panel view-injuries-panel)
(require racket/gui "workout.rkt" "gui-helpers.rkt" map-widget (only-in "classes.rkt" injury%))


;; workout

(define (add-workout-panel parent add-workout)
  (let* ((top (new vertical-panel% [parent parent] [alignment '(center center)]))
         (workout #f))
    (new button% [parent top]
         [label "Upload Workout"]
         [callback (lambda (btn evt)
                     (set! workout (parse-gpx (get-file)))
                     (add-workout workout)
                     (view-single-workout-panel top workout))])
    top))



(define (view-workouts-panel parent workouts)
  (view-panel parent
              (lambda (workout) (date->string (get-field start-date workout)))
              workouts
              view-single-workout-panel))


(define (view-single-workout-panel parent workout)
  (let* ((top (new horizontal-panel%
                   [parent parent]
                   [min-height 400]
                   [stretchable-height #f]))
         (info (new vertical-panel% [parent top] [alignment '(center center)]))
         (map (new map-widget% [parent top])))
    
    ;; draw route on map
    (send map add-layer (line-layer 'workout (get-field route workout)))
    (send map zoom-level 13)
    (send map move-to (car (get-field route workout)))

    ;; show information
        
    ;  start-date end-date route max-elevation min-elevation
    (new show-date% [parent info]
         [label "start"]
         [date (get-field start-date workout)])
    (new show-date% [parent info]
         [label "end"]
         [date (get-field end-date workout)])
    (new show-horizontal-value% [parent info]
         [label "minimum elevation"]
         [value (number->string (get-field min-elevation workout))])
    (new show-horizontal-value% [parent info]
         [label "maximum elevation"]
         [value (number->string  (get-field max-elevation workout))])

    (define training-intensity (new message% [parent info]
                                    [label (string-append "the training intensity based on your data is: "
                                                          (number->string (get-field training-intensity workout))
                                                          "/10")]))

    (define intensity (new slider%
                           [label "perceived intensity"]
                           [min-value 0]
                           [max-value 10]
                           [parent info]
                           [callback (lambda (s e)
                                       (let ((perceived-intensity (send s get-value)))
                                         (begin-train (set-field! perceived-intensity workout perceived-intensity))))]))
    (send intensity set-value (get-field perceived-intensity workout))

    (let ((injuries (get-field injuries workout)))
      (unless (null? injuries)
        (let ((injury-panel (new vertical-panel% [parent info])))
          (new message% [parent injury-panel] [label "Injuries:"])
          (for-each
           (lambda (injury)
             (let ((row (new horizontal-panel% [parent injury-panel])))
               (new message%
                    [parent row]
                    [label (get-field body-part injury)])
               (new button%
                    [parent row]
                    [label "View"]
                    [callback
                     (lambda (btn evt)
                       (send parent delete-child top)
                       (view-single-injury-panel parent injury))])))
           injuries))))
    
    top))


;; injury

(define (add-injury-panel parent add-injury workouts)
  (let ((top (new vertical-panel% [parent parent])))

    (let ((date (new date-time-input%
                     [parent top]
                     [label "When: "]
                     [max-year 2026]))
          (what (new text-field%
                     [parent top]
                     [label "What happened: "]))
          (body-part (new custom-choice%
                          [parent top]
                          [label "Body part: "]
                          [choices '("leg" "knee" "ankle" "foot"
                                           "arm" "shoulder" "back" "other")]
                          [init "leg"]))
          (workout
           (new custom-choice%
                [parent top]
                [label "Workout: "]
                [choices (cons "none"
                               (map (lambda (w)
                                      (date->string (get-field start-date w)))
                                    workouts))]
                [real-ones (cons #f workouts)]
                [init "none"]))
          (recovered? (new check-box%
                           [parent top]
                           [label "Recovered?"])))

      (new button%
           [parent top]
           [label "Add"]
           [callback
            (lambda (btn evt)
              (let* ((assoc-workout (send workout get-value))
                     (injury (new injury%
                                  [when (send date get-value)]
                                  [what (send what get-value)]
                                  [body-part (send body-part get-value)]
                                  [associated-workout assoc-workout]
                                  [recovered? (send recovered? get-value)])))
                (add-injury injury)
                (when  assoc-workout
                  (send assoc-workout assoc-injury! injury))

                (view-single-injury-panel top injury)))])

      top)))

(define (view-single-injury-panel parent injury)
  (let* ((top (new vertical-panel%
                   [parent parent]
                   [min-height 250]
                   [stretchable-height #f]))
         (info (new vertical-panel%
                    [parent top])))

    ;; show information
    (new show-date% [parent info]
         [label "when: "]
         [date (get-field when injury)])

    (new show-horizontal-value% [parent info]
         [label "what: "]
         [value (get-field what injury)])

    (new show-horizontal-value% [parent info]
         [label "body part: "]
         [value (get-field body-part injury)])
    
    (let ((workout (get-field associated-workout injury)))
      (when workout
        (new show-horizontal-value% [parent info]
             [label "workout: "]
             [value (date->string (get-field start-date workout))])
        (new button%
             [parent info]
             [label "View workout"]
             [callback
              (lambda (btn evt)
                ;; remove current panel and show workout
                (send parent delete-child top)
                (view-single-workout-panel parent workout))])))

    (new show-horizontal-value% [parent info]
         [label "recovered: "]
         [value (if (get-field recovered? injury) "yes" "no")])
    (unless (get-field recovered? injury)
      (new button%
           [parent info]
           [label "Mark as recovered"]
           [callback
            (lambda (btn evt)
              (set-field! recovered? injury #t)
              ;; refresh view
              (send parent delete-child top)
              (view-single-injury-panel parent injury))]))

    top))


(define (view-injuries-panel parent injuries)
  (view-panel parent
              (lambda (injury)
                (date->string (get-field when injury)))
              injuries
              view-single-injury-panel))


