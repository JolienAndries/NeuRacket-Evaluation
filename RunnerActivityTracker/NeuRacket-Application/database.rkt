#lang racket/base

(provide database)
(require racket/class)
(require (only-in "classes.rkt" user% user-race% race% injury%) (only-in "workout.rkt" parse-gpx) (only-in "neural-slices.rkt" training-intensity-slice))

(define database% (class object%
                    (super-new)
                    (field [users '()]
                           [races '()])
                    (define/public (get-races)
                      (map cdr races))
                    (define/public (get-user username)
                      (let ((user (assoc username users)))
                        (if user 
                            (cdr user)
                            #f)))
                    (define/public (get-race racename)
                      (let ((race (assoc racename races)))
                        (if race 
                            (cdr race)
                            #f)))
                    (define/public (add-user user)
                      (set! users (cons (cons (get-field name user) user) users)))
                    (define/public (add-race! race)
                      (set! races (cons (cons (get-field name race) race) races)))))

(define database (new database%))

(define (fill-database!)
  (let* ((20bxl (parse-gpx "../../../gpx-workouts/20km_door_Brussel_Strava_Export.gpx"))
         (S2R5.2 (parse-gpx "../../../gpx-workouts/S2R_W5S2.gpx"))
         (S2R5.3 (parse-gpx "../../../gpx-workouts/S2R_W5S3.gpx"))
         (brussels-20k (new race% [name "Brussels 20K"] [place "Brussels"] [date (make-date 0 0 0 12 05 2024 0 0 #f 0)] [distance 20] [elevation-difference 150]))
         (amsterdam-marathon (new race% [name "Amsterdam Marathon"] [place "Amsterdam"] [date (make-date 0 0 0 06 10 2026 0 0 #f 0)] [distance 42.195] [elevation-difference 120]))
         (vienna-marathon (new race% [name "Vienna Marathon"] [place "Vienna"] [date (make-date 0 0 0 20 04 2027 0 0 #f 0)] [distance 42.195] [elevation-difference 85]))
         (jolien (new user% [name "Jolien"] [password "TS"] [birthday (make-date 0 0 0 29 01 2003 0 0 #f 0)] [sex "V"] [weight 55] [height 173]
                      [workouts (list S2R5.2 S2R5.3)]))
         (evi (new user% [name "Evi"] [password "PT"] [birthday (make-date 0 0 0 17 10 2006 0 0 #f 0)] [sex "V"] [weight 50] [height 170] [workouts (list 20bxl)]))
         (evi-brussels-race (new user-race% [race brussels-20k]))
         (jolien-amsterdam-race (new user-race% [race amsterdam-marathon]))
         (evi-injury (new injury% [when (make-date 0 0 0 01 05 2024 0 0 #f 0)]
                          [associated-workout 20bxl]
                          [what "ankle sprain"]
                          [body-part "ankle"]
                          [recovered? #t]))
         (jolien-injury (new injury% [when (make-date 0 0 0 15 04 2026 0 0 #f 0)]
                             [associated-workout S2R5.3]
                             [what "hamstring strain"]
                             [body-part "leg"]
                             [recovered? #f])))
    (set-field! users database (list (cons (get-field name jolien) jolien)
                                     (cons (get-field name evi) evi)))
    (new-neural-slice training-intensity-slice 20bxl evi)
    (new-neural-slice training-intensity-slice S2R5.2 jolien)
    (new-neural-slice training-intensity-slice S2R5.3 jolien)
    (send evi add-injury! evi-injury)
    (send jolien add-injury! jolien-injury)
    (set-field! races database (list (cons (get-field name brussels-20k) brussels-20k)
                                     (cons (get-field name amsterdam-marathon) amsterdam-marathon)
                                     (cons (get-field name vienna-marathon) vienna-marathon)))
    (send brussels-20k register evi)
    (send evi register evi-brussels-race)
    (send evi-brussels-race assoc-workout! 20bxl)
    (send evi race-run! evi-brussels-race)
    
    (send amsterdam-marathon register jolien)
    (send jolien register jolien-amsterdam-race)))


(fill-database!)