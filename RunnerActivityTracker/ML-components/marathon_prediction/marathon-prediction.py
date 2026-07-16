import sys

sys.path.append("../ML-components/marathon_prediction") # needed for raceTimePrediction

import raceTimePrediction
import tensorflow as tf
import numpy as np

model = raceTimePrediction.load_model()



xoffset = np.array([5000.0, 855.5, 8045.0, 1600.0, 10.0], dtype=np.float32)
gain = np.array([0.0002, 0.0003, 0.0002, 0.0002, 0.0182], dtype=np.float32)
ymin_in = -1.0

xoffset_out = 8217.1
gain_out = 1.3410e-04
ymin_out = -1.0


def preprocess(x):
    x = np.asarray(x, dtype=np.float32)
    return (x - xoffset) * gain + ymin_in
def postprocess(y_norm):
    return (y_norm - ymin_out) / gain_out + xoffset_out


def predict_time(race1, race2, mileage, race_length):
    x_norm = preprocess(race1 + race2 + [mileage])
    x_tensor = tf.convert_to_tensor([x_norm], dtype=tf.float32)
    output = model.predict(x_tensor)
    y_norm = output[0][0]
    y = postprocess(y_norm) # how long it would take to run the marathon in seconds
    y = y * race_length / 42 # time * length / 42 
    return tuple([float(y) / 3600])

def train_marathon_time(time,race1, race2, mileage, race_length):
    file_out = open("../../../new_marathon_results.csv", "a")
    lst = race1 + race2 + [mileage, time * 42 / race_length]
    line = ','.join([str(x) for x in lst]) + '\n'
    file_out.write(line)
    file_out.close()


