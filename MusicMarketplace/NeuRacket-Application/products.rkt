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
                 (neural-field [(genre instrument bpm) audio-model (file)])))



;;;;;;;;;;;;;;;;;;; product ;;;;;;;;;;;;;;;;;;; 


(define product% (class object%
                   (super-new)
                   (init-field seller content product-format [times-viewed 0] [times-sold 0])
                   (abstract-neural-field [(price) (times-viewed times-sold)])
                   (define/public (buy) #f)))

(define physical% (class product%
                    (inherit-field price product-format)
                    (super-new)
                    
                    (init-field  media-condition sleeve-condition [stock 0])

                    (override-neural-field [(price) price-model-physical (product-format media-condition sleeve-condition stock)])

                    (define/override (buy)
                      (if (> stock 0)
                          (begin (set! stock (- stock 1)) #t)
                          #f))))

        

(define vinyl% (class physical%
                 (super-new [product-format "vinyl"])
                 (inherit-field price media-condition sleeve-condition stock)
                     
                 (init-field RPM size)

                 (augment-neural-field [(price) price-model-vinyl (RPM size)])))
                 

(define digital% (class product%
                   (inherit-field price)
                   (super-new [product-format "digital"])
                   
                   (init-field
                    [file #f]
                    [file-kind #f])

                   (override-neural-field [(price) price-model-digital (file-kind)])
                  
                   (define/override (buy) #t)))

                   


