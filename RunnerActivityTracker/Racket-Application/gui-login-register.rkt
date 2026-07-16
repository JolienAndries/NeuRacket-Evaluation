#lang racket/base
(require racket/gui (only-in "classes.rkt" user%) "gui-helpers.rkt") ; 
(provide login-panel register-panel)

(define (login-panel main login-user register)
  (let ((login-panel 
         (new vertical-panel%
              [parent main]
              [alignment '(center center)]
              [style '(deleted)]
              [border 200]
              [spacing 100])))
                        
   
    (define login-name-field (new text-field%
                                  [label "Name"]
                                  [parent login-panel]))
   
    (define login-password-field (new text-field%
                                      [label "Password"]
                                      [parent login-panel]
                                      [style '(single password)]))

    (define button-panel
      (new horizontal-pane%
           [parent login-panel]
           [alignment '(center center)]
           [spacing 150]))
                       
   
    (new button%
         [parent button-panel]
         [label "Log In"]
         [callback
          (lambda (btn evt)
            (login-user (send login-name-field get-value) (send login-password-field get-value)))])

    (new button%
         [parent button-panel]
         [label "Register"]
         [callback
          (lambda (btn evt)
            (register))])

    login-panel))

(define (register-panel main register)
  (let ((register-panel (new vertical-panel%
                             [parent main]
                             [alignment '(center center)]
                             [style '(deleted)]
                             [border 100]
                             [spacing 50])))


    (define name-field (new text-field%
                            [label "Name"]
                            [parent register-panel]))
   
    (define password-field (new text-field%
                                [label "Password"]
                                [parent register-panel]
                                [style '(single password)]))


    (define birthday (new date-input% [parent register-panel] [label "Birthday"] [max-year 2010]))

    (define sex (new custom-choice%
                     [label "Sex"]
                     [parent register-panel]
                     [choices (list "M" "V" "X" "Prefer Not To Say")]
                     [init "M"]))

    (define weight (new number-input% [label "Weight (kg)"] [parent register-panel]))
    (define height (new number-input% [label "Height (cm)"] [parent register-panel]))

    (new button%
         [parent register-panel]
         [label "Register"]
         [callback
          (lambda (btn evt)
            (register (new user% [name (send name-field get-value)]
                           [password (send password-field get-value)]
                           [birthday (send birthday get-value)]
                           [sex (send sex get-value)]
                           [height (send height get-value)]
                           [weight (send weight get-value)])))])


    register-panel))




