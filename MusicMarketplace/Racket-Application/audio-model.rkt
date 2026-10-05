#lang racket/base
(require racket/class racket/vector "python-conversion.rkt")
(provide audio-model)

(define audio-model
  (new (class object% (super-new)
         (run* "with open('../ML-components/audio.py') as file: exec(file.read())")
         (define python-train (run "train"))
         (define python-infer (run "infer"))
                           
         (define/public (train file-path genre instrument bpm)
           (apply python-train (map scheme->python
                                    (list genre instrument bpm (path->string file-path)))))
                           
         (define/public (infer file-path)
           (vector-map python->scheme
                       (python->scheme (python-infer (scheme->python (path->string file-path)))))))))
