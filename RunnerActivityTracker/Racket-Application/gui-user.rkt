#lang racket/base

(require racket/gui "classes.rkt" "gui-helpers.rkt")
(provide profile-panel)

(define (profile-panel parent user)
  (let ((top (new vertical-panel% [parent parent] [alignment '(center center)] [spacing 20])))
    (new message% [parent top] [label "User profile"])

    (new show-horizontal-value% [parent top]
         [label "Name: "]
         [value (get-field name user)])

    (new show-horizontal-value% [parent top]
         [label "Birthday: "]
         [value (date->string (get-field birthday user))])

    (new show-horizontal-value% [parent top]
         [label "Height: "]
         [value (number->string (get-field height user))])

    (define (weight-display)
      (let ((row (new horizontal-panel% [parent top] [spacing 10])))
        (new message% [parent row] [label "Weight (kg): "])
        (new message% [parent row] [label (number->string (get-field weight user))])
        (new button% [parent row]
             [label "Change weight!"]
             [callback (lambda (btn evt)
                         (send top delete-child row)
                         (change-weight))])
        row))

    (define (change-weight)
      (let ((row (new horizontal-panel% [parent top] [spacing 10])))
        (define weight-field
          (new text-field%
               [parent row]
               [label "Weight (kg): "]
               [init-value (number->string (get-field weight user))]))
        (new button%
             [parent row]
             [label "Save weight"]
             [callback
              (lambda (btn evt)
                (let ((new-weight (string->number (send weight-field get-value))))
                  (when new-weight
                    (set-field! weight user new-weight)
                    (message-box "Success" "Weight updated successfully")
                    (send top delete-child row)
                    (weight-display))))])
        row))

    (weight-display)

    top))
