#lang racket/base
(require racket/class "audio-model.rkt" "price-model.rkt")

(provide album% physical% product% track% digital% vinyl%)



;;;;;;;;;;;;;;;;;;; music ;;;;;;;;;;;;;;;;;;; 
(define music% (class object%
                 (init-field
                  title
                  artist
                  release-year
                  mood
                  [languages '()])
                 (super-new)))

(define album% (class music% 
                 (init-field
                  genre 
                  [description ""]
                  [tracks '()]
                  [selling-formats '()]
                  [cover #f])   
                 
                 (super-new)))

(define track% (class music%
                 (super-new)
                 (inherit-field title artist release-year languages mood)
                 (init-field file)
                 (field  [instrument #f]
                         [genre #f]
                         [bpm #f])


                 (define/private (update-predictions-track!)
                   (let ((predicted (send audio-model infer file)))
                     (unless instrument
                       (set-field! instrument this (vector-ref predicted 0)))
                     (unless genre
                       (set-field! genre this  (vector-ref predicted 1)))
                     (unless bpm
                       (set-field! bpm this  (vector-ref predicted 2)))))
                 
                 (define/private (train-on-track!)
                   (send audio-model train file genre instrument bpm))

                                  
                 (define/public (set-file! new-file)
                   (set-field! file this new-file)
                   (update-predictions-track!))

                 (define/public (set-instrument-genre-bpms! new-instrument new-genre new-bpm)
                   (set-field! instrument this new-instrument)
                   (set-field! genre this new-genre)
                   (set-field! bpm this new-bpm)
                   (train-on-track!))
                   

                 ;; initialise
                 (cond ((and file instrument genre bpm) ;; all are there -> train
                        (train-on-track!))
                       (file ;; file is there -> predict rest
                        (update-predictions-track!)))))



;;;;;;;;;;;;;;;;;;; product ;;;;;;;;;;;;;;;;;;; 


(define product% (class object%
                   (super-new)
                   (define times-viewed 0)
                   (define times-sold 0)
                   (init-field seller content product-format)
                   (field [price #f])
                   (field [predicted-price #f])
                   (define/public (buy) (set! times-sold (+ times-sold 1)) #t)
                   (abstract set-price!)
                   (abstract get-predicted-price)))

(define physical% (class product%
                    (inherit-field predicted-price price product-format)
                    (super-new)
                    
                    (init-field  media-condition sleeve-condition [stock 0])

                    (define/override (buy)
                      (if (> stock 0)
                          (begin (set! stock (- stock 1)) (super buy))
                          #f))

                    (define/private (update-predictions!)
                      (let ((predicted (send price-model-physical infer product-format media-condition sleeve-condition stock)))
                        (set-field! predicted-price this (vector-ref predicted 0))))
                 
                    (define/private (train-price!)
                      (send price-model-physical train product-format media-condition sleeve-condition stock price))

                    (define/override (set-price! new-price)
                      (set-field! price this new-price)
                      (train-price!))
                    
                    (define/override (get-predicted-price)
                      (update-predictions!) ;; want to infer before you return (latest)
                      predicted-price)))



(define vinyl% (class physical%
                 (super-new [product-format "vinyl"])
                 (inherit-field price predicted-price product-format media-condition sleeve-condition stock)
                     
                 (init-field RPM size)

                 (define/private (update-predictions!)
                   (let ((predicted (send price-model-vinyl infer product-format media-condition sleeve-condition stock RPM size)))
                     (set-field! predicted-price this (vector-ref predicted 0))))
                 
                 (define/private (train-price!)
                   (send price-model-vinyl train product-format media-condition sleeve-condition stock RPM size price))

                 (define/override (set-price! new-price)
                   (set-field! price this new-price)
                   (train-price!))

                 (define/override (get-predicted-price)
                   (update-predictions!) ;; want to infer before you return (latest)
                   predicted-price)))
                 

(define digital% (class product%
                   (inherit-field price predicted-price)
                   (super-new [product-format "digital"])
                   
                   (init-field
                    [file #f]
                    [file-kind #f])
                  
                   (define/override (buy) #t)

                   (define/private (update-predictions!)
                     (let ((predicted (send price-model-digital infer file-kind)))
                       (set-field! predicted-price this (vector-ref predicted 0))))
                 
                   (define/private (train-price!)
                     (send price-model-digital train file-kind price))

                   (define/override (set-price! new-price)
                     (set-field! price this new-price)
                     (train-price!))

                   (define/override (get-predicted-price)
                     (update-predictions!) ;; want to infer before you return (latest)
                     predicted-price)))

