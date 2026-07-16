#lang racket/base
(require racket/class)
(require racket/vector)

(provide audio-model)

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

(define audio-model (new (class object% (super-new)
                           (run* "with open('../ML-components/audio.py') as file: exec(file.read())")
                           (define python-train (run "train"))
                           (define python-infer (run "infer"))
                           
                           (define/public (train file-path genre instrument bpm)
                             (apply python-train (map convert-scheme-value (list genre instrument bpm (path->string file-path)))))
                           
                           (define/public (infer file-path)
                             (vector-map convert-python-value (pytuple->vector (python-infer (string->pystring (path->string file-path)))))))))
