#lang racket/base
(require racket/class)
(provide artist% regular%)

(define user% (class object%
                (init-field username password location birth-year [main-genre #f] [overarching-mood #f] [biography ""] 
                            [to-sell '()]
                            [sold '()])
                (external-neural-field relevant-albums)

                (define/public (sell-album! album)
                  (set! to-sell (cons album to-sell)))

                (define/public (sold-album! album)
                  (set! to-sell (cons album to-sell)))
                (super-new)))

(define artist% (class user%                     
                  (field [discography '()])

                  (define/public (release-album! album)
                    (set! discography (cons album discography)))
                  (super-new)))

(define regular% (class user%
                   (super-new)
                   (inherit-field birth-year main-genre overarching-mood)
                   (field [bought '()])
                   (define/public (buy-album! album)
                     (set! bought (cons album bought)))))