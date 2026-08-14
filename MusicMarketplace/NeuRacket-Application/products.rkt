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
                 (inherit-field title artist release-year mood languages)
                 (init-field file)
                 (label-field [genre #f] [instrument #f] [bpm #f])
                 (neural-field [(predicted-genre predicted-instrument predicted-bpm) audio-model (file) (genre instrument bpm)])))



;;;;;;;;;;;;;;;;;;; product ;;;;;;;;;;;;;;;;;;; 


(define product% (class object%
                   (super-new)
                   (init-field seller content product-format [times-viewed 0] [times-sold 0])
                   (label-field [price #f])
                   (abstract-neural-field [(predicted-price) (times-viewed times-sold) (price)])
                   (define/public (buy) #f)))

(define physical% (class product%
                    (inherit-field price product-format)
                    (super-new)
                    
                    (init-field media-condition sleeve-condition [stock 0])

                    (override-neural-field [(predicted-price) price-model-physical (product-format media-condition sleeve-condition stock) (price)])

                    (define/override (buy)
                      (if (> stock 0)
                          (begin (set! stock (- stock 1)) #t)
                          #f))))

        

(define vinyl% (class physical%
                 (super-new [product-format "vinyl"])
                 (inherit-field price media-condition sleeve-condition stock)
                     
                 (init-field RPM size)

                 (augment-neural-field [(predicted-price) price-model-vinyl (RPM size) (price)])))
                 

(define digital% (class product%
                   (inherit-field price)
                   (super-new [product-format "digital"])
                   (init-field
                    [file #f]
                    [file-kind #f])
                    (override-neural-field [(predicted-price) price-model-digital (file-kind) (price)])
                  
                   (define/override (buy) #t)))

                   


