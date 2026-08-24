#lang racket
(require mlobject)
(provide (all-defined-out))

(define path-to-python-file "./train-and-infer-functions.py")


(defMLObject model-1-in-1-out
  [file path-to-python-file]
  [infer "infer_1_in_1_out"]
  [train "train_1_in_1_out"]
  [input in1]
  [label out1])

;; inputs changing 

(defMLObject model-3-in-1-out
  [file path-to-python-file]
  [infer "infer_3_in_1_out"]
  [train "train_3_in_1_out"]
  [input in1 in2 in3]
  [label out1])

(defMLObject model-5-in-1-out
  [file path-to-python-file]
  [infer "infer_5_in_1_out"]
  [train "train_5_in_1_out"]
  [input in1 in2 in3 in4 in5]
  [label out1])

(defMLObject model-7-in-1-out
  [file path-to-python-file]
  [infer "infer_7_in_1_out"]
  [train "train_7_in_1_out"]
  [input in1 in2 in3 in4 in5 in6 in7]
  [label out1])

(defMLObject model-9-in-1-out
  [file path-to-python-file]
  [infer "infer_9_in_1_out"]
  [train "train_9_in_1_out"]
  [input in1 in2 in3 in4 in5 in6 in7 in8 in9]
  [label out1])

(defMLObject model-11-in-1-out
  [file path-to-python-file]
  [infer "infer_11_in_1_out"]
  [train "train_11_in_1_out"]
  [input in1 in2 in3 in4 in5 in6 in7 in8 in9 in10 in11]
  [label out1])

(defMLObject model-13-in-1-out
  [file path-to-python-file]
  [infer "infer_13_in_1_out"]
  [train "train_13_in_1_out"]
  [input in1 in2 in3 in4 in5 in6 in7 in8 in9 in10 in11 in12 in13]
  [label out1])

(defMLObject model-15-in-1-out
  [file path-to-python-file]
  [infer "infer_15_in_1_out"]
  [train "train_15_in_1_out"]
  [input in1 in2 in3 in4 in5 in6 in7 in8 in9 in10 in11 in12 in13 in14 in15]
  [label out1])

(defMLObject model-17-in-1-out
  [file path-to-python-file]
  [infer "infer_17_in_1_out"]
  [train "train_17_in_1_out"]
  [input in1 in2 in3 in4 in5 in6 in7 in8 in9 in10 in11 in12 in13 in14 in15 in16 in17]
  [label out1])

(defMLObject model-19-in-1-out
  [file path-to-python-file]
  [infer "infer_19_in_1_out"]
  [train "train_19_in_1_out"]
  [input in1 in2 in3 in4 in5 in6 in7 in8 in9 in10 in11 in12 in13 in14 in15 in16 in17 in18 in19]
  [label out1])

;; outputs changing 

(defMLObject model-1-in-3-out
  [file path-to-python-file]
  [infer "infer_1_in_3_out"]
  [train "train_1_in_3_out"]
  [input in1]
  [label out1 out2 out3])

(defMLObject model-1-in-5-out
  [file path-to-python-file]
  [infer "infer_1_in_5_out"]
  [train "train_1_in_5_out"]
  [input in1]
  [label out1 out2 out3 out4 out5])

(defMLObject model-1-in-7-out
  [file path-to-python-file]
  [infer "infer_1_in_7_out"]
  [train "train_1_in_7_out"]
  [input in1]
  [label out1 out2 out3 out4 out5 out6 out7])

(defMLObject model-1-in-9-out
  [file path-to-python-file]
  [infer "infer_1_in_9_out"]
  [train "train_1_in_9_out"]
  [input in1]
  [label out1 out2 out3 out4 out5 out6 out7 out8 out9])

(defMLObject model-1-in-11-out
  [file path-to-python-file]
  [infer "infer_1_in_11_out"]
  [train "train_1_in_11_out"]
  [input in1]
  [label out1 out2 out3 out4 out5 out6 out7 out8 out9 out10 out11])

(defMLObject model-1-in-13-out
  [file path-to-python-file]
  [infer "infer_1_in_13_out"]
  [train "train_1_in_13_out"]
  [input in1]
  [label out1 out2 out3 out4 out5 out6 out7 out8 out9 out10 out11 out12 out13])

(defMLObject model-1-in-15-out
  [file path-to-python-file]
  [infer "infer_1_in_15_out"]
  [train "train_1_in_15_out"]
  [input in1]
  [label out1 out2 out3 out4 out5 out6 out7 out8 out9 out10 out11 out12 out13 out14 out15])

(defMLObject model-1-in-17-out
  [file path-to-python-file]
  [infer "infer_1_in_17_out"]
  [train "train_1_in_17_out"]
  [input in1]
  [label out1 out2 out3 out4 out5 out6 out7 out8 out9 out10 out11 out12 out13 out14 out15 out16 out17])

(defMLObject model-1-in-19-out
  [file path-to-python-file]
  [infer "infer_1_in_19_out"]
  [train "train_1_in_19_out"]
  [input in1]
  [label out1 out2 out3 out4 out5 out6 out7 out8 out9 out10 out11 out12 out13 out14 out15 out16 out17 out18 out19])