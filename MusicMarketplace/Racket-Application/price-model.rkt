#lang racket/base
(require racket/class)
(require racket/vector)

(provide (all-defined-out))
;; initialise pyffi
(require pyffi)
(initialize)
(post-initialize)


(define (convert-python-value value)
  (cond ((pystring? value) (pystring->string value))
        (else value)))

(define (convert-scheme-value value)
  (cond ((string? value) (string->pystring value))
        (else value)))


(define price-model-digital (new (class object% (super-new)
                                   (run* "with open('../ML-components/price.py') as file: exec(file.read())")
                                   (define python-train (run "train_digital"))
                                   (define python-infer (run "infer_digital"))
                                   (define/public (train file-kind price)
                                     (apply python-train (map convert-scheme-value (list price file-kind))))
                                   (define/public (infer file-kind)
                                     (vector-map convert-python-value (pytuple->vector  (apply python-infer (map convert-scheme-value (list file-kind)))))))))

(define price-model-vinyl (new (class object% (super-new)
                                 (run* "with open('../ML-components/price.py') as file: exec(file.read())")
                                 (define python-train (run "train_vinyl"))
                                 (define python-infer (run "infer_vinyl"))
                                 (define/public (train product-format media-condition sleeve-condition stock rpm size price)
                                   (apply python-train (map convert-scheme-value (list price product-format media-condition sleeve-condition stock rpm size))))
                                 (define/public (infer product-format  media-condition sleeve-condition stock rpm size)
                                   (vector-map convert-python-value     (pytuple->vector  (apply python-infer (map convert-scheme-value (list product-format media-condition sleeve-condition stock rpm size)))))))))

(define price-model-physical (new (class object% (super-new)
                                    (run* "with open('../ML-components/price.py') as file: exec(file.read())")
                                    (define python-train (run "train_physical"))
                                    (define python-infer (run "infer_physical"))
                                    (define/public (train format media-condition sleeve-condition stock price)
                                      (apply python-train (map convert-scheme-value (list price format media-condition sleeve-condition stock))))
                                    (define/public (infer format media-condition sleeve-condition stock)
                                      (vector-map convert-python-value   (pytuple->vector  (apply python-infer (map convert-scheme-value (list format media-condition sleeve-condition stock)))))))))
