#lang racket/base
(provide (all-defined-out))

(require pyffi)
(initialize)
(post-initialize)

(run* "with open('./train-and-infer-functions.py') as file: exec(file.read())")

(define infer-1-in-1-out (run "infer_1_in_1_out"))
(define train-1-in-1-out (run "train_1_in_1_out"))
 
;; inputs changing 
(define infer-3-in-1-out (run "infer_3_in_1_out"))
(define train-3-in-1-out (run "train_3_in_1_out"))

(define infer-5-in-1-out (run "infer_5_in_1_out"))
(define train-5-in-1-out (run "train_5_in_1_out"))

(define infer-7-in-1-out (run "infer_7_in_1_out"))
(define train-7-in-1-out (run "train_7_in_1_out"))

(define infer-9-in-1-out (run "infer_9_in_1_out"))
(define train-9-in-1-out (run "train_9_in_1_out"))

(define infer-11-in-1-out (run "infer_11_in_1_out"))
(define train-11-in-1-out (run "train_11_in_1_out"))

(define infer-13-in-1-out (run "infer_13_in_1_out"))
(define train-13-in-1-out (run "train_13_in_1_out"))

(define infer-15-in-1-out (run "infer_15_in_1_out"))
(define train-15-in-1-out (run "train_15_in_1_out"))

(define infer-17-in-1-out (run "infer_17_in_1_out"))
(define train-17-in-1-out (run "train_17_in_1_out"))

(define infer-19-in-1-out (run "infer_19_in_1_out"))
(define train-19-in-1-out (run "train_19_in_1_out"))

;; outputs changing
(define infer-1-in-3-out (run "infer_1_in_3_out"))
(define train-1-in-3-out (run "train_1_in_3_out"))

(define infer-1-in-5-out (run "infer_1_in_5_out"))
(define train-1-in-5-out (run "train_1_in_5_out"))

(define infer-1-in-7-out (run "infer_1_in_7_out"))
(define train-1-in-7-out (run "train_1_in_7_out"))

(define infer-1-in-9-out (run "infer_1_in_9_out"))
(define train-1-in-9-out (run "train_1_in_9_out"))

(define infer-1-in-11-out (run "infer_1_in_11_out"))
(define train-1-in-11-out (run "train_1_in_11_out"))

(define infer-1-in-13-out (run "infer_1_in_13_out"))
(define train-1-in-13-out (run "train_1_in_13_out"))

(define infer-1-in-15-out (run "infer_1_in_15_out"))
(define train-1-in-15-out (run "train_1_in_15_out"))

(define infer-1-in-17-out (run "infer_1_in_17_out"))
(define train-1-in-17-out (run "train_1_in_17_out"))

(define infer-1-in-19-out (run "infer_1_in_19_out"))
(define train-1-in-19-out (run "train_1_in_19_out"))