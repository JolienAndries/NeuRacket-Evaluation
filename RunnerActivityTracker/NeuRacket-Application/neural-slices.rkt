#lang racket

(require (only-in "MLObjects.rkt" racetime-model training-intensity-model))
(provide marathon-time-prediction-slice training-intensity-slice)

  

(defneuralslice (marathon-time-prediction-slice user marathon-prediction)
  [input-fields  [marathon-prediction predicting-workout1]
                 [marathon-prediction predicting-workout2]
                 [user workouts] [marathon-prediction race]]
  [label-fields [marathon-prediction workout]]
  [target-fields [marathon-prediction time-prediction]]
  [MLObject racetime-model])

(defneuralslice (training-intensity-slice workout user)
  [input-fields  [workout elevation-difference] [workout duration] [workout distance]
                 [user birthday] [user weight] [user height] [user workouts]]
  [label-fields  [workout perceived-intensity]]
  [target-fields [workout training-intensity]]
  [MLObject training-intensity-model])

#| todo remove
(defneuralslice (training-intensity-slice workout user)
  [target-fields [workout training-intensity]]
  [input-fields  [workout elevation-difference] [workout duration] [workout distance]
                 [workout duration] [workout distance]
                 [user birthday] [user weight] [user height]
                 [user workouts] [user workouts][user workouts][user workouts]]
  [MLObject training-intensity-model]
  [label-fields  [workout perceived-intensity]])
|#