#lang racket/base
(require mlobject)
(provide (all-defined-out))

(defMLObject price-model-digital
  [file "../ML-components/price.py"];;"/Users/jolienandries/Documents/NeuRacket/ML-components/price.py"]
  [infer "infer_digital"]
  [train "train_digital"]
  [input file-kind]
  [label price])

(defMLObject price-model-vinyl
  [file "../ML-components/price.py"];;"/Users/jolienandries/Documents/NeuRacket/ML-components/price.py"]
  [infer "infer_vinyl"]
  [train "train_vinyl"]
  [input product-format media-condition sleeve-condition stock rpm size]
  [label price])

(defMLObject price-model-physical
  [file "../ML-components/price.py"];;"/Users/jolienandries/Documents/NeuRacket/ML-components/price.py"]
  [infer "infer_physical"]
  [train "train_physical"]
  [input product-format media-condition sleeve-condition stock]
  [label price])