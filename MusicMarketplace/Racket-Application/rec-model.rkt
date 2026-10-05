#lang racket/base
(require racket/class racket/vector "python-conversion.rkt")
(provide (all-defined-out))

(define (album->needed-fields album)
  (list (get-field title album)
        (get-field username (get-field artist album))
        (get-field genre album)
        (get-field mood album)
        (get-field release-year album)))


(define recommendation-model
  (new (class object% (super-new)
         (run* "with open('../ML-components/recommendation.py') as file: exec(file.read())")
         (define python-train (run "train"))
         (define python-infer (run "infer"))
         (define/public (train user-genre user-bought user-mood user-birth possible-albums chosen-albums)
           (apply python-train (map scheme->python
                                    (list (map album->needed-fields chosen-albums)
                                          user-genre
                                          (map album->needed-fields user-bought)
                                          user-mood user-birth
                                          (map album->needed-fields possible-albums)))))
         (define/public (infer user-genre user-bought user-mood user-birth possible-albums)
           (python->scheme (apply python-infer (map scheme->python
                                                          (list user-genre
                                                                (map album->needed-fields user-bought)
                                                                user-mood user-birth
                                                                (map album->needed-fields possible-albums)))))))))
