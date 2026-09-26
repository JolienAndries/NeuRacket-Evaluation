#lang racket

(require racket/gui "gui-login-register.rkt" "gui-workout-injury.rkt" "database.rkt" "gui-race.rkt")



(define (swap-panel-to new-panel)
  (send main change-children (lambda (_) '()))
  (send main add-child new-panel))

(define main-menu% (class object%
                     (init-field parent)
                     (field [user #f])
                     (field [menu-bar (new menu-bar% [parent parent])])
                     (field [workout  (new menu% [label "Workout"]
                                           [parent menu-bar])]
                            [races (new menu% [label "Races"]
                                        [parent menu-bar])]
                            [injuries (new menu% [label "Injuries"] [parent menu-bar])]
                            [profile (new menu% [label "Home"]
                                          [parent menu-bar])])
                     ;; workout
                     (new menu-item% [label "add workout"]
                          [parent workout]
                          [callback (lambda (mnu evt) (swap-panel-to (add-workout-panel main (lambda (workout)
                                                                                               (send user add-workout! workout)))))])
                     (new menu-item% [label "view workouts"]
                          [parent workout]
                          [callback (lambda (mnu evt) (swap-panel-to (view-workouts-panel main (get-field workouts user))))])
                     ;; races
                     (new menu-item% [label "add new race"]
                          [parent races]
                          [callback (lambda (mnu evt) (swap-panel-to (add-race-panel main (lambda (race) (send database add-race! race)))))])
                     (new menu-item% [label "view races"]
                          [parent races]
                          [callback (lambda (mnu evt) (swap-panel-to (view-races-panel main (send database get-races) user)))])
                     ;; injury
                     (new menu-item% [label "add injury"]
                          [parent injuries]
                          [callback (lambda (mnu evt) (swap-panel-to (add-injury-panel main (lambda (injury) (send user add-injury! injury)) (get-field workouts user))))])
                     (new menu-item% [label "view injuries"]
                          [parent injuries]
                          [callback (lambda (mnu evt) (swap-panel-to (view-injuries-panel main (get-field injuries user))))])
    
                     ;; profile
                     (new menu-item% [label "home"]
                          [parent profile]
                          [callback (lambda (mnu evt) (swap-panel-to (main-page main user)))])
                     (new menu-item% [label "log out"]
                          [parent profile]
                          [callback (lambda (mnu evt)
                                      (logout)
                                      (swap-panel-to (login-panel main login-user login-to-register)))])

                     (define/public (login new-user) 
                       (set! user new-user)
                       (send menu-bar enable #t))
                     (define/public (logout)
                       (send menu-bar enable #f)
                       (set! user #f))
                     (send menu-bar enable #f)
                     (super-new)))

(define (main-page parent user)
  (let ((top (new vertical-panel% [parent parent])))
    ;;;
    (define injury-alert (new panel% [parent top]
                              [min-height 600]
                              [stretchable-height #f]
                              [style '(border)]))
    (new message%
         [label (if (get-field injury-risk? user)
                    "ALERT - YOU ARE RUNNING THE RISK OF HAVING AN INJURY"
                    "No risk of an injury, but still, be careful!")]
         [parent injury-alert])


    
    (let ((races (get-field upcoming-races user)))
      (unless (null? races)
        (let ((race-panel (new vertical-panel% [parent top])))
      
          (new message%
               [parent race-panel]
               [label "Upcoming races"])
          (view-races-panel race-panel (map (lambda (usr-race) (get-field race usr-race)) (get-field upcoming-races user)) user))))
    top))


  
(define main (new frame% [label "Runner's App"]
                  [width 1200] [height 750]))
(define main-menu (new main-menu% [parent main]))

;;;
(define (login-user username password)
  (let ((user (send database get-user username)))
    (when (and user (send user correct-password? password))
      (swap-panel-to (main-page main user))
      (send main-menu login user))))
(define (register user)
  (let ((other-user (send database get-user (get-field name user))))
    (unless other-user
      (swap-panel-to (main-page main user))
      (send database add-user user)
      (send main-menu login user))))
(define (login-to-register)
  (swap-panel-to (register-panel main register)))
;;;

  

;;(send main delete-child (login-panel main))
   
(send main add-child (login-panel main login-user login-to-register))

  
(send main show #t)



