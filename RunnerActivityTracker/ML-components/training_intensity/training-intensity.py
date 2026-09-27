import tensorflow as tf
import numpy as np

model_path = '../ML-components/training_intensity/training_intensity_model.keras'

intensity_model = tf.keras.models.load_model(model_path)



def train_training_intensity(training_intensity, elevation_difference, duration, distance, speed, age, weight, length, average_workout_elevation_diff, average_workout_duration, average_workout_distance, average_workout_speed):
    # do not use adam for batch training because it resets https://github.com/keras-team/keras/issues/1868#issuecomment-191722497
    # adam -> sgd is a thing: https://stackoverflow.com/questions/69816120/starting-with-adam-and-then-fine-tune-with-sgd-changing-the-optimizer
    # SGD optimiser 
    intensity_model.compile(optimizer=tf.keras.optimizers.SGD(learning_rate=0.001), loss='mean_absolute_error')
    # need to expand to batch size: (-> [[x]] instead of [x])
    # https://stackoverflow.com/questions/63907380/incremental-learning-in-keras
    input = np.array([[elevation_difference, duration, distance, speed, age, weight, length, average_workout_elevation_diff, average_workout_duration, average_workout_distance, average_workout_speed]])
    output = np.array([[training_intensity]])

    intensity_model.train_on_batch(tf.convert_to_tensor(input), tf.convert_to_tensor(output))
    intensity_model.save(model_path)


def predict_training_intensity(elevation_difference, duration, distance, speed, age, weight, length, average_workout_elevation_diff, average_workout_duration, average_workout_distance, average_workout_speed):
    res = intensity_model.predict(np.array([[elevation_difference, duration, distance, speed, age, weight, length, average_workout_elevation_diff, average_workout_duration, average_workout_distance, average_workout_speed]]))
    res = res[0][0]
    res = round(res.item(), 2)
    res = 10 if res > 10 else (0 if res < 0 else res)
    return res



#y = predict_training_intensity(70,105,18.8,10.7,27,69,175,68,102,17.8,10.4)
#print("prediction, ", y)
#train_training_intensity(70,105,18.8,10.7,27,69,175,68,102,17.8,10.4,9.5)
#print("trained")
#y = predict_training_intensity(70,105,18.8,10.7,27,69,175,68,102,17.8,10.4)
#print("prediction after training, ", y)
