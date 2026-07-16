#lang racket
(require  racket/gui)
(provide (all-defined-out))

(define custom-choice% (class choice%
                         (init-field choices [init #f] [real-ones #f])
                         (super-new [choices choices])
                         (define/public (get-value)
                           (if real-ones
                               (let ((selection (send this get-selection)))
                                 (if selection
                                     (list-ref real-ones selection)
                                     #f))
                               (send this get-string-selection)))
                         (when init
                           (send this set-string-selection init))))


(define choice-number-input% (class object%
                               (init-field parent label min max)
                               (field [choice (new custom-choice%
                                                   [label label]
                                                   [parent parent]
                                                   [choices (map number->string (stream->list (in-range min (+ max 1))))]
                                                   [init (number->string min)])])
                               (define/public (get-value)
                                 (string->number (send choice get-value)))
                               (super-new)))

(define number-input% (class text-field%
                        (super-new)
                        (define/override (get-value)
                          (string->number (super get-value)))))
                     
(define date-input%
  (class object%
    (init-field parent label max-year)
    (field [date-pane (new horizontal-pane%
                           [parent parent]
                           [min-height 50]
                           [stretchable-height #f])])
    (new message% [parent date-pane] [label label])
    (field [day (new choice-number-input%
                     [label "day"]
                     [parent date-pane]
                     [min 1]
                     [max 31])]
           [month (new choice-number-input%
                       [label "month"]
                       [parent date-pane]
                       [min 1]
                       [max 12])]
           [year (new choice-number-input%
                      [label "year"]
                      [parent date-pane]
                      [min 1900]
                      [max max-year])])

    (define/public (get-value)
      (make-date 0 0 0
                 (send day get-value)
                 (send month get-value)
                 (send year get-value)
                 0 0 #f 0))
    (super-new)))

(define date-time-input%
  (class date-input%
    (super-new)
    (inherit-field day month year date-pane)

    (define hour (new choice-number-input%
                      [label "hour"]
                      [parent date-pane]
                      [min 0]
                      [max 23]))
    (define minutes  (new choice-number-input%
                          [label "minutes"]
                          [parent date-pane]
                          [min 0]
                          [max 59]))

    (define/override (get-value)
      (make-date 0
                 (send minutes get-value)
                 (send hour get-value)
                 (send day get-value)
                 (send month get-value)
                 (send year get-value)
                 0 0 #f 0))))
   
                      
(define (date->string date)
  (string-append (number->string (date-day date)) "/"
                 (number->string (date-month date)) "/"
                 (number->string (date-year date))))
(define show-date%
  (class object%
    (super-new)
    (init-field date label parent)
    (field [pane (new horizontal-pane% [parent parent])])

    (new message% [parent pane]
         [label label])
    (new message% [parent pane]
         [label (date->string date)])
    (new message% [parent pane]
         [label (string-append (number->string (date-hour date)) ":"
                               (number->string (date-minute date)) ":"
                               (number->string (date-second date)))])))


(define show-horizontal-value% (class object% (super-new)
                                 (init-field parent label value)
                                 (define pane (new horizontal-pane% [parent parent]))
                                 (new message% [parent pane]
                                      [label label])
                                 (new message% [parent pane]
                                      [label value])))


(define (view-panel parent get-label lst single-panel)
  (let* ((top (new vertical-panel% [parent parent])))
    ;; listbox met de data daarop klikken dan een voor een de workout details zien

    (define list-box (new list-box%
                          [label "all workouts"]
                          [parent top]
                          [choices (map get-label lst)]
                          [style '(single column-headers)]
                          [callback (lambda (lbx evt)
                                      (let ((selection (send lbx get-selections)))
                                        (send top change-children (lambda (children) (list list-box)))
                                        (unless (null? selection)
                                          (let ((selected (list-ref lst (car selection))))
                                            (single-panel top selected)))))]))
    top))
