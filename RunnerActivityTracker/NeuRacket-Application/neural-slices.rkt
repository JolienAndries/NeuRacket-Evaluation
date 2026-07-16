#lang racket

(require (only-in "MLObjects.rkt" racetime-model training-intensity-model))
(provide marathon-time-prediction-slice training-intensity-slice)

(defneuralslice (marathon-time-prediction-slice user marathon-prediction)
  [target-fields [marathon-prediction time-prediction]]
  [input-fields  [marathon-prediction predicting-workout1] [marathon-prediction predicting-workout2] [user workouts] [marathon-prediction race]]
  [MLObject racetime-model])

(defneuralslice (training-intensity-slice workout user)
  [target-fields [workout training-intensity]]
  [input-fields [workout elevation-difference] [workout duration] [workout distance]
                [workout duration] [workout distance]
                [user birthday] [user weight] [user height]
                [user workouts] [user workouts][user workouts][user workouts]]
  [MLObject training-intensity-model])