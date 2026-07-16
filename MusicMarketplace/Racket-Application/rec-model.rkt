#lang racket/base
(require racket/class)
(require racket/vector)
(provide (all-defined-out))
;; initialise pyffi
(require pyffi)
(initialize)
(post-initialize)


(define (album->needed-fields album)
  (list (get-field title album)
        (get-field username (get-field artist album))
        (get-field genre album)
        (get-field mood album)
        (get-field release-year album)))


(define (convert-python-value value)
  (cond ((pystring? value) (pystring->string value))
        ((pytuple? value) (vector-map convert-python-value (pytuple->vector value)))
        ((pylist? value) (map convert-python-value (pylist->list value)))
        (else value)))

(define (convert-scheme-value value)
  (cond ((string? value) (string->pystring value))
        ((vector? value)  (vector->pytuple (vector-map convert-scheme-value value)))
        ((list? value)  (list->pylist (map convert-scheme-value value)))
        (else value)))




(define recommendation-model (new (class object% (super-new)
                                    (run* "with open('../ML-components/recommendation.py') as file: exec(file.read())")
                                    (define python-train (run "train"))
                                    (define python-infer (run "infer"))
                                    (define/public (train user-genre user-bought user-mood user-birth possible-albums chosen-albums)
                                      (apply python-train (map convert-scheme-value (list (map album->needed-fields chosen-albums) user-genre (map album->needed-fields user-bought) user-mood user-birth (map album->needed-fields possible-albums)))))
                                    (define/public (infer user-genre user-bought user-mood user-birth possible-albums)
                                      (convert-python-value (apply python-infer (map convert-scheme-value (list user-genre (map album->needed-fields user-bought) user-mood user-birth (map album->needed-fields possible-albums)))))))))
