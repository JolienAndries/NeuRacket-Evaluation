#lang racket/base
(provide marketplace)
(require "population-values.rkt" "rec-model.rkt" racket/class)

;; neural-slice
(defneuralslice (recommendation-slice user marketplace)
  [input-fields  [user main-genre] [user bought] [user overarching-mood] [user birth-year] [marketplace albums]] 
  [label-fields  [user bought]]
  [target-fields [user relevant-albums]] 
  [MLObject recommendation-model])


(defneuralslice (artist-recommendation-slice user marketplace)
  [input-fields  [user main-genre] [user discography] [user overarching-mood] [user birth-year] [marketplace albums]] ;; inputfields adhv argumenten
  [label-fields  [user discography]]
  [target-fields [user relevant-albums]] ;; target fields adhv argumenten
  [MLObject recommendation-model])


;;;;;;;;;;;;;;;;;;; singleton "warehouse" ;;;;;;;;;;;;;;;;;;; 
(define marketplace (new (class object%
                           (field [products '()]
                                  [albums album-population]
                                  [artists artist-population]
                                  [regular-users '()]
                                  [current-user #f])

                           ;; add "concepts"
                           (define/public (add-album! album) 
                             (set! albums (cons album albums)))
                           (define/public (add-digital! digital)
                             (set! products (cons digital products)))
                           (define/public (add-analogue! analogue)
                             (set! products (cons analogue products)))
                         
                           (define/public (buy-product! product)
                             (if current-user
                                 (begin (send product buy)
                                        (send current-user buy-album! (get-field content product)))
                                 (displayln "Please log in to buy a product.")))

                           (define/public (sell-product! product price)
                              (if current-user
                                 (let ((album (get-field content product)))
                                   ;; update marketplace catalogue and album selling-formats
                                   (set-field! price product price)
                                   (set! products (cons product products))
                                   (set-field! selling-formats album (cons product (get-field selling-formats album))))
                                 (displayln "Please log in to sell a product.")))

                           (define (find-user username)
                             (member username (append regular-users artists) (lambda (usr-n regular)
                                                                               (equal? usr-n (get-field username regular)))))

                           (define/public (add-regular-user? user)
                             (let ((username (get-field username user)))
                               (cond ((find-user username)  #f)
                                     (else (set! regular-users (cons user regular-users))
                                           (set! current-user user)
                                           (new-neural-slice recommendation-slice user this) 
                                           #t))))

                           (define/public (add-artist? user)
                             (let ((username (get-field username user)))
                               (cond ((find-user username) #f)
                                     (else (set! artists (cons user artists))
                                           (set! current-user user)
                                           (new-neural-slice artist-recommendation-slice user marketplace)
                                           #t))))

                           (define/public (find-album title artist)
                             (findf (lambda (possible-album)
                                      (and (equal? title (get-field title possible-album)) (equal? artist (get-field username (get-field artist possible-album))))) albums))

                           ;; log in / log out
                           (define/public (log-in-if-possible? username password)
                             (let* ((users (find-user username))
                                    (user-password  (if users (get-field password (car users)) #f)))
                               (cond
                                 [(and users (equal? user-password password))  (set! current-user (car users)) #t]
                                 [else #f])))

                           (define/public (log-out!)
                             (set! current-user #f))
                         
                           (super-new))))


