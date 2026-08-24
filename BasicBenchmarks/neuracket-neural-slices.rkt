#lang racket
(provide (all-defined-out))
(require "neuracket-ML-models.rkt")
;; 1 in 1 out
(defneuralslice (1-in-1-out-slice obj-in obj-out)
  [input-fields  [obj-in a]]
  [label-fields  [obj-out lbl1]]
  [target-fields [obj-out external-neural]]
  [MLObject model-1-in-1-out])

;; 1 in x out
(defneuralslice (1-in-3-out-slice obj-in obj-out1 obj-out2 obj-out3)
  [input-fields  [obj-in a]]
  [label-fields  [obj-out1 lbl1] [obj-out2 lbl2] [obj-out3 lbl3]]
  [target-fields [obj-out1 external-neural] [obj-out2 external-neural2] [obj-out3 external-neural3]]
  [MLObject model-1-in-3-out])

(defneuralslice (1-in-5-out-slice obj-in obj-out1 obj-out2 obj-out3 obj-out4 obj-out5)
  [input-fields  [obj-in a]]
  [label-fields  [obj-out1 lbl1] [obj-out2 lbl2] [obj-out3 lbl3] [obj-out4 lbl4] [obj-out5 lbl5]]
  [target-fields [obj-out1 external-neural] [obj-out2 external-neural2][obj-out3 external-neural3] [obj-out4 external-neural4][obj-out5 external-neural5]]
  [MLObject model-1-in-5-out])

(defneuralslice (1-in-7-out-slice obj-in obj-out1 obj-out2 obj-out3 obj-out4 obj-out5 obj-out6 obj-out7)
  [input-fields  [obj-in a]]
  [label-fields  [obj-out1 lbl1] [obj-out2 lbl2] [obj-out3 lbl3] [obj-out4 lbl4] [obj-out5 lbl5] [obj-out6 lbl6] [obj-out7 lbl7]]
  [target-fields [obj-out1 external-neural] [obj-out2 external-neural2] [obj-out3 external-neural3] [obj-out4 external-neural4] [obj-out5 external-neural5] [obj-out6 external-neural6] [obj-out7 external-neural7]]
  [MLObject model-1-in-7-out])

(defneuralslice (1-in-9-out-slice obj-in obj-out1 obj-out2 obj-out3 obj-out4 obj-out5 obj-out6 obj-out7 obj-out8 obj-out9)
  [input-fields  [obj-in a]]
  [label-fields  [obj-out1 lbl1] [obj-out2 lbl2] [obj-out3 lbl3] [obj-out4 lbl4] [obj-out5 lbl5] [obj-out6 lbl6] [obj-out7 lbl7] [obj-out8 lbl8] [obj-out9 lbl9]]
  [target-fields [obj-out1 external-neural] [obj-out2 external-neural2] [obj-out3 external-neural3] [obj-out4 external-neural4] [obj-out5 external-neural5] [obj-out6 external-neural6] [obj-out7 external-neural7] [obj-out8 external-neural8] [obj-out9 external-neural9]]
  [MLObject model-1-in-9-out])

(defneuralslice (1-in-11-out-slice obj-in obj-out1 obj-out2 obj-out3 obj-out4 obj-out5 obj-out6 obj-out7 obj-out8 obj-out9 obj-out10 obj-out11)
  [input-fields  [obj-in a]]
  [label-fields  [obj-out1 lbl1] [obj-out2 lbl2] [obj-out3 lbl3] [obj-out4 lbl4] [obj-out5 lbl5] [obj-out6 lbl6] [obj-out7 lbl7] [obj-out8 lbl8] [obj-out9 lbl9] [obj-out10 lbl10] [obj-out11 lbl11]]
  [target-fields [obj-out1 external-neural] [obj-out2 external-neural2] [obj-out3 external-neural3] [obj-out4 external-neural4] [obj-out5 external-neural5] [obj-out6 external-neural6] [obj-out7 external-neural7] [obj-out8 external-neural8] [obj-out9 external-neural9] [obj-out10 external-neural10] [obj-out11 external-neural11]]
  [MLObject model-1-in-11-out])

(defneuralslice (1-in-13-out-slice obj-in obj-out1 obj-out2 obj-out3 obj-out4 obj-out5 obj-out6 obj-out7 obj-out8 obj-out9 obj-out10 obj-out11 obj-out12 obj-out13)
  [input-fields  [obj-in a]]
  [label-fields  [obj-out1 lbl1] [obj-out2 lbl2] [obj-out3 lbl3] [obj-out4 lbl4] [obj-out5 lbl5] [obj-out6 lbl6] [obj-out7 lbl7] [obj-out8 lbl8] [obj-out9 lbl9] [obj-out10 lbl10] [obj-out11 lbl11]  [obj-out12 lbl12] [obj-out13 lbl13]]
  [target-fields [obj-out1 external-neural] [obj-out2 external-neural2] [obj-out3 external-neural3] [obj-out4 external-neural4] [obj-out5 external-neural5] [obj-out6 external-neural6] [obj-out7 external-neural7] [obj-out8 external-neural8] [obj-out9 external-neural9] [obj-out10 external-neural10] [obj-out11 external-neural11] [obj-out12 external-neural12] [obj-out13 external-neural13]]
  [MLObject model-1-in-13-out])

(defneuralslice (1-in-15-out-slice obj-in obj-out1 obj-out2 obj-out3 obj-out4 obj-out5 obj-out6 obj-out7 obj-out8 obj-out9 obj-out10 obj-out11 obj-out12 obj-out13 obj-out14 obj-out15)
  [input-fields  [obj-in a]]
  [label-fields  [obj-out1 lbl1] [obj-out2 lbl2] [obj-out3 lbl3] [obj-out4 lbl4] [obj-out5 lbl5] [obj-out6 lbl6] [obj-out7 lbl7] [obj-out8 lbl8] [obj-out9 lbl9] [obj-out10 lbl10] [obj-out11 lbl11] [obj-out12 lbl12] [obj-out13 lbl13][obj-out14 lbl14] [obj-out15 lbl15]]
  [target-fields [obj-out1 external-neural] [obj-out2 external-neural2] [obj-out3 external-neural3] [obj-out4 external-neural4] [obj-out5 external-neural5] [obj-out6 external-neural6] [obj-out7 external-neural7] [obj-out8 external-neural8] [obj-out9 external-neural9] [obj-out10 external-neural10] [obj-out11 external-neural11] [obj-out12 external-neural12] [obj-out13 external-neural13] [obj-out14 external-neural14] [obj-out15 external-neural15]]
  [MLObject model-1-in-15-out])

(defneuralslice (1-in-17-out-slice obj-in obj-out1 obj-out2 obj-out3 obj-out4 obj-out5 obj-out6 obj-out7 obj-out8 obj-out9 obj-out10 obj-out11 obj-out12 obj-out13 obj-out14 obj-out15 obj-out16 obj-out17)
  [input-fields  [obj-in a]]
  [label-fields  [obj-out1 lbl1] [obj-out2 lbl2] [obj-out3 lbl3] [obj-out4 lbl4] [obj-out5 lbl5] [obj-out6 lbl6] [obj-out7 lbl7] [obj-out8 lbl8] [obj-out9 lbl9] [obj-out10 lbl10] [obj-out11 lbl11] [obj-out12 lbl12] [obj-out13 lbl13] [obj-out14 lbl14] [obj-out15 lbl15][obj-out16 lbl16] [obj-out17 lbl17]]
  [target-fields [obj-out1 external-neural] [obj-out2 external-neural2] [obj-out3 external-neural3] [obj-out4 external-neural4] [obj-out5 external-neural5] [obj-out6 external-neural6] [obj-out7 external-neural7] [obj-out8 external-neural8] [obj-out9 external-neural9] [obj-out10 external-neural10] [obj-out11 external-neural11] [obj-out12 external-neural12] [obj-out13 external-neural13] [obj-out14 external-neural14] [obj-out15 external-neural15] [obj-out16 external-neural16] [obj-out17 external-neural17]]
  [MLObject model-1-in-17-out])

(defneuralslice (1-in-19-out-slice obj-in obj-out1 obj-out2 obj-out3 obj-out4 obj-out5 obj-out6 obj-out7 obj-out8 obj-out9 obj-out10 obj-out11 obj-out12 obj-out13 obj-out14 obj-out15 obj-out16 obj-out17 obj-out18 obj-out19)
  [input-fields  [obj-in a]]
  [label-fields  [obj-out1 lbl1] [obj-out2 lbl2] [obj-out3 lbl3] [obj-out4 lbl4] [obj-out5 lbl5] [obj-out6 lbl6] [obj-out7 lbl7] [obj-out8 lbl8] [obj-out9 lbl9] [obj-out10 lbl10] [obj-out11 lbl11] [obj-out12 lbl12] [obj-out13 lbl13] [obj-out14 lbl14] [obj-out15 lbl15][obj-out16 lbl16] [obj-out17 lbl17] [obj-out18 lbl18] [obj-out19 lbl19]]
  [target-fields [obj-out1 external-neural] [obj-out2 external-neural2] [obj-out3 external-neural3] [obj-out4 external-neural4] [obj-out5 external-neural5] [obj-out6 external-neural6] [obj-out7 external-neural7] [obj-out8 external-neural8] [obj-out9 external-neural9] [obj-out10 external-neural10] [obj-out11 external-neural11] [obj-out12 external-neural12] [obj-out13 external-neural13] [obj-out14 external-neural14] [obj-out15 external-neural15] [obj-out16 external-neural16] [obj-out17 external-neural17] [obj-out18 external-neural18] [obj-out19 external-neural19]]
  [MLObject model-1-in-19-out])


;; y in 1 out
(defneuralslice (3-in-1-out-slice obj-in1 obj-in2 obj-in3 obj-out)
  [input-fields  [obj-in1 a] [obj-in2 a] [obj-in3 a]]
  [label-fields  [obj-out lbl1]]
  [target-fields [obj-out external-neural]]
  [MLObject model-3-in-1-out])

(defneuralslice (5-in-1-out-slice obj-in1 obj-in2 obj-in3 obj-in4 obj-in5 obj-out)
  [input-fields  [obj-in1 a] [obj-in2 a] [obj-in3 a] [obj-in4 a] [obj-in5 a]]
  [label-fields  [obj-out lbl1]]
  [target-fields [obj-out external-neural]]
  [MLObject model-5-in-1-out])

(defneuralslice (7-in-1-out-slice obj-in1 obj-in2 obj-in3 obj-in4 obj-in5 obj-in6 obj-in7 obj-out)
  [input-fields  [obj-in1 a] [obj-in2 a] [obj-in3 a] [obj-in4 a] [obj-in5 a] [obj-in6 a] [obj-in7 a]]
  [label-fields  [obj-out lbl1]]
  [target-fields [obj-out external-neural]]
  [MLObject model-7-in-1-out])

(defneuralslice (9-in-1-out-slice obj-in1 obj-in2 obj-in3 obj-in4 obj-in5 obj-in6 obj-in7 obj-in8 obj-in9 obj-out)
  [input-fields  [obj-in1 a] [obj-in2 a] [obj-in3 a] [obj-in4 a] [obj-in5 a] [obj-in6 a] [obj-in7 a] [obj-in8 a] [obj-in9 a]]
  [label-fields  [obj-out lbl1]]
  [target-fields [obj-out external-neural]]
  [MLObject model-9-in-1-out])

(defneuralslice (11-in-1-out-slice obj-in1 obj-in2 obj-in3 obj-in4 obj-in5 obj-in6 obj-in7 obj-in8 obj-in9 obj-in10 obj-in11 obj-out)
  [input-fields  [obj-in1 a] [obj-in2 a] [obj-in3 a] [obj-in4 a] [obj-in5 a] [obj-in6 a] [obj-in7 a] [obj-in8 a] [obj-in9 a] [obj-in10 a] [obj-in11 a]]
  [label-fields  [obj-out lbl1]]
  [target-fields [obj-out external-neural]]
  [MLObject model-11-in-1-out])

(defneuralslice (13-in-1-out-slice obj-in1 obj-in2 obj-in3 obj-in4 obj-in5 obj-in6 obj-in7 obj-in8 obj-in9 obj-in10 obj-in11 obj-in12 obj-in13 obj-out)
  [input-fields  [obj-in1 a] [obj-in2 a] [obj-in3 a] [obj-in4 a] [obj-in5 a] [obj-in6 a] [obj-in7 a] [obj-in8 a] [obj-in9 a] [obj-in10 a] [obj-in11 a] [obj-in12 a] [obj-in13 a]]
  [label-fields  [obj-out lbl1]]
  [target-fields [obj-out external-neural]]
  [MLObject model-13-in-1-out])

(defneuralslice (15-in-1-out-slice obj-in1 obj-in2 obj-in3 obj-in4 obj-in5 obj-in6 obj-in7 obj-in8 obj-in9 obj-in10 obj-in11 obj-in12 obj-in13 obj-in14 obj-in15 obj-out)
  [input-fields  [obj-in1 a] [obj-in2 a] [obj-in3 a] [obj-in4 a] [obj-in5 a] [obj-in6 a] [obj-in7 a] [obj-in8 a] [obj-in9 a] [obj-in10 a] [obj-in11 a] [obj-in12 a] [obj-in13 a] [obj-in14 a] [obj-in15 a]]
  [label-fields  [obj-out lbl1]]
  [target-fields [obj-out external-neural]]
  [MLObject model-15-in-1-out])

(defneuralslice (17-in-1-out-slice obj-in1 obj-in2 obj-in3 obj-in4 obj-in5 obj-in6 obj-in7 obj-in8 obj-in9 obj-in10 obj-in11 obj-in12 obj-in13 obj-in14 obj-in15 obj-in16 obj-in17 obj-out)
  [input-fields  [obj-in1 a] [obj-in2 a] [obj-in3 a] [obj-in4 a] [obj-in5 a] [obj-in6 a] [obj-in7 a] [obj-in8 a] [obj-in9 a] [obj-in10 a] [obj-in11 a] [obj-in12 a] [obj-in13 a] [obj-in14 a] [obj-in15 a] [obj-in16 a] [obj-in17 a]]
  [label-fields  [obj-out lbl1]]
  [target-fields [obj-out external-neural]]
  [MLObject model-17-in-1-out])

(defneuralslice (19-in-1-out-slice obj-in1 obj-in2 obj-in3 obj-in4 obj-in5 obj-in6 obj-in7 obj-in8 obj-in9 obj-in10 obj-in11 obj-in12 obj-in13 obj-in14 obj-in15 obj-in16 obj-in17 obj-in18 obj-in19 obj-out)
  [input-fields  [obj-in1 a] [obj-in2 a] [obj-in3 a] [obj-in4 a] [obj-in5 a] [obj-in6 a] [obj-in7 a] [obj-in8 a] [obj-in9 a] [obj-in10 a] [obj-in11 a] [obj-in12 a] [obj-in13 a] [obj-in14 a] [obj-in15 a] [obj-in16 a] [obj-in17 a] [obj-in18 a] [obj-in19 a]]
  [label-fields  [obj-out lbl1]]
  [target-fields [obj-out external-neural]]
  [MLObject model-19-in-1-out])