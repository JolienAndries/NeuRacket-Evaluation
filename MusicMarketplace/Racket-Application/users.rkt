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
                   (inherit-field birth-year main-genre overarching-mood
                                  relevant-albums)
                   (define previous-possible-albums '())
                   (field [bought '()])

                   (define/override (get-relevant-albums possible-albums)
                     (if (equal? possible-albums previous-possible-albums)
                         relevant-albums
                         (let* ((predicted (send recommendation-model infer main-genre bought overarching-mood birth-year possible-albums))
                                (predicted-albums (vector-ref predicted 0)))
                           (set! previous-possible-albums possible-albums)
                           (set-field! relevant-albums this predicted-albums)
                           predicted-albums)))

                   (define/public (buy-album! album possible-albums)
                     (set! bought (cons album bought))
                     (send recommendation-model train main-genre bought overarching-mood birth-year possible-albums relevant-albums))))


