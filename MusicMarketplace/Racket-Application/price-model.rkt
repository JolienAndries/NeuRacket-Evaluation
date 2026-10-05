#lang racket/base
(require racket/class "python-conversion.rkt")

(provide (all-defined-out))


(define price-model-digital
  (new (class object% (super-new)
         (run* "with open('../ML-components/price.py') as file: exec(file.read())")
         (define python-train (run "train_digital"))
         (define python-infer (run "infer_digital"))
         (define/public (train file-kind price)
           (apply python-train (map scheme->python (list price file-kind))))
         (define/public (infer file-kind)
           (python->scheme (apply python-infer (map scheme->python (list file-kind))))))))

(define price-model-vinyl
  (new (class object% (super-new)
         (run* "with open('../ML-components/price.py') as file: exec(file.read())")
         (define python-train (run "train_vinyl"))
         (define python-infer (run "infer_vinyl"))
         (define/public (train product-format media-condition sleeve-condition stock rpm size price)
           (apply python-train (map scheme->python (list price product-format media-condition
                                                         sleeve-condition stock rpm size))))
         (define/public (infer product-format  media-condition sleeve-condition stock rpm size)
           (python->scheme (apply python-infer
                                  (map scheme->python (list product-format
                                                            media-condition
                                                            sleeve-condition
                                                            stock rpm size))))))))

(define price-model-physical
  (new (class object% (super-new)
         (run* "with open('../ML-components/price.py') as file: exec(file.read())")
         (define python-train (run "train_physical"))
         (define python-infer (run "infer_physical"))
         (define/public (train format media-condition sleeve-condition stock price)
           (apply python-train (map scheme->python (list price format media-condition sleeve-condition
                                                         stock))))
         (define/public (infer format media-condition sleeve-condition stock)
           (python->scheme (apply python-infer
                                  (map scheme->python
                                       (list format media-condition sleeve-condition stock))))))))
