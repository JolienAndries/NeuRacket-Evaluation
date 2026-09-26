#lang racket

(require (only-in "MLObjects.rkt" racetime-model))
(provide marathon-time-prediction-slice)

  

(defneuralslice (marathon-time-prediction-slice user marathon-prediction)
  [input-fields  [marathon-prediction predicting-workout1]
                 [marathon-prediction predicting-workout2]
                 [user workouts] [marathon-prediction race]]
  [label-fields [marathon-prediction workout]]
  [target-fields [marathon-prediction time-prediction]]
  [MLObject racetime-model])
