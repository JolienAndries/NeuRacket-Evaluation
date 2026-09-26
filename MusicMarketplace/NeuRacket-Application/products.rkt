#lang racket/base
(require racket/class "audio-model.rkt" "price-model.rkt")

(provide album% physical% product% track% digital% vinyl% sales%)

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
                   (define times-viewed 0)
                   (define times-sold 0)
                   (init-field seller content product-format)
                   (label-field [price #f])
                   (field [on-sale? #f])
                   (abstract-neural-field [(predicted-price) (times-viewed times-sold) (price)])
                   (define/public (view) (set! times-viewed (+ times-viewed 1)))
                   (define/public (buy) (set! times-sold (+ times-sold 1)) #t)))

(define physical% (class product%
                    (inherit-field product-format)
                    (super-new)
                    
                    (init-field media-condition sleeve-condition [init-stock 0])

                    (define current-stock init-stock)

                    (override-neural-field [(predicted-price) price-model-physical (product-format media-condition sleeve-condition current-stock) (super)])

                    (define/override (buy)
                      (if (> current-stock 0)
                          (begin (set! current-stock (- current-stock 1)) (super buy))
                          #f))))

        

(define vinyl% (class physical%
                 (super-new [product-format "vinyl"])
                 (inherit-field media-condition sleeve-condition)
                     
                 (init-field RPM size)

                 (override-neural-field [(predicted-price) price-model-vinyl (super RPM size) (super)])))
                 

(define digital% (class product%
                   (super-new [product-format "digital"])
                   (init-field
                    [file #f]
                    [file-kind #f])
                   (override-neural-field [(predicted-price) price-model-digital (file-kind) (super)])))



(define sales% (class object%
                 (super-new)
                 (init-field product [target-conversion 0.1])
                 (label-field [price #f])
                 (external-neural-field predicted-price)
                 (define old-price (get-field price product))

                 (define/public (sales-done!)
                   (set-field! price product old-price)
                   (set-field! on-sale? product #f))

                 
                 (defneuralslice (sales-slice sales product)
                   [input-fields [sales target-conversion] [product times-viewed] [product times-sold] [product price]]
                   [label-fields [sales price]]
                   [target-fields [sales predicted-price]]
                   [MLObject price-model-sales])
                 (new-neural-slice sales-slice this product)))
