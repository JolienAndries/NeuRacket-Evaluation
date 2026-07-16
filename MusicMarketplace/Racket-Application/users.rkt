#lang racket/base
(require racket/class "rec-model.rkt")

(provide artist% regular%)




(define user% (class object%
                (init-field username password location birth-year [main-genre #f] [overarching-mood #f] [biography ""] 
                            [to-sell '()]
                            [sold '()])
                (field [relevant-albums '()])
                
                (define/public (sell-album! album)
                  (set! to-sell (cons album to-sell)))

                (define/public (sold-album! album)
                  (set! to-sell (cons album to-sell)))

                (define/public (set-relevant-albums! new-relevant-albums)
                  (set-field! relevant-albums this  new-relevant-albums))

                (define/public (get-relevant-albums possible-albums)
                  relevant-albums)
                
                (super-new)))

(define artist% (class user%      
                  (inherit-field relevant-albums)
                  (field [discography '()])

                  (define/public (release-album! album)
                    (set! discography (cons album discography)))
                  (super-new)))

(define regular% (class user%
                   (super-new)
                   (inherit-field birth-year main-genre overarching-mood relevant-albums)
                   (field [bought '()])


                   (define/private (update-predictions! possible-albums)
                     (let ((predicted (send recommendation-model infer main-genre bought overarching-mood birth-year  possible-albums)))
                       (set-field! relevant-albums this (vector-ref predicted 0))))
                 
                   (define/private (train-albums! possible-albums)
                     (send recommendation-model train main-genre bought overarching-mood birth-year possible-albums relevant-albums))

                   (define/override (set-relevant-albums! new-relevant-albums)
                     (super set-relevant-albums! new-relevant-albums)
                     (train-albums! new-relevant-albums))

                   (define/override (get-relevant-albums possible-albums)
                     (update-predictions! possible-albums) ;; want to infer before you return (latest)
                     (super get-relevant-albums possible-albums))

                   (define/public (buy-album! album)
                     (set! bought (cons album bought)))))


