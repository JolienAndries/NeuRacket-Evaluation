#lang racket/base
(require mlobject (only-in racket/function identity))
(provide audio-model)


(defMLObject audio-model
  [file "../ML-components/audio.py"]
  [infer "infer"]
  [train "train"]
  [input (path->string file-path)]
  [label genre instrument bpm])
