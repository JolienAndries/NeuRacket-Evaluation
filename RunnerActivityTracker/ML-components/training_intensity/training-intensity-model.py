import sys
import os

import tensorflow as tf
import numpy as np
import pandas as pd
from tensorflow.keras import layers
from sklearn.model_selection import train_test_split

# https://www.tensorflow.org/tutorials/load_data/csv
# https://www.tensorflow.org/tutorials/keras/regression

dataset = pd.read_csv("../ML-components/training_intensity/training-data.csv")
features = dataset.drop("training_intensity", axis=1)
labels = dataset["training_intensity"]

train_features, test_features, train_labels, test_labels = train_test_split(features, labels, test_size=0.20, random_state=42)

normaliser = tf.keras.layers.Normalization(axis=-1)
normaliser.adapt(np.array(train_features))

intensity_model = tf.keras.Sequential([
    normaliser,
    layers.Dense(8, activation='relu'),
    layers.Dense(1)
])

intensity_model.compile(optimizer=tf.keras.optimizers.Adam(learning_rate=0.1), loss='mean_absolute_error')

intensity_model.fit(train_features, train_labels, epochs=100, verbose=0, validation_split = 0.2)

test_results = intensity_model.evaluate(test_features, test_labels, verbose=2)

# prints the same information as verbose = 2
#print(intensity_model.metrics_names)
#print(test_results)

#test_predictions = intensity_model.predict(test_features).flatten()
#error = test_predictions - test_labels
#print(error)
model_path = '../ML-components/training_intensity/training_intensity_model.keras'
intensity_model.save(model_path)

reloaded = tf.keras.models.load_model(model_path)

reloaded.evaluate(test_features, test_labels, verbose=2)

# see if it does much better on training data: 
reloaded.evaluate(train_features, train_labels, verbose=2)