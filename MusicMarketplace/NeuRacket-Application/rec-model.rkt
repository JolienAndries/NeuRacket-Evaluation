#lang racket/base
(require mlobject (only-in racket/function identity) racket/class)
(provide (all-defined-out))

(defMLObject recommendation-model
  [file "../ML-components/recommendation.py"]
  [infer "infer"]
  [train "train"]
  [input user-genre (extract-albums user-bought) user-mood user-birth (extract-albums possible-albums)]
  [label (extract-albums chosen-albums)]

  (define (album->needed-fields album)
    (list (get-field title album)
          (get-field username (get-field artist album))
          (get-field genre album)
          (get-field mood album)
          (get-field release-year album)))
  (define (extract-albums albums)
    (map album->needed-fields albums)))