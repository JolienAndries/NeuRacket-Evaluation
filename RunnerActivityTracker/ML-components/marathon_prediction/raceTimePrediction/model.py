#    This file was created by
#    MATLAB Deep Learning Toolbox Converter for TensorFlow Models.
#    30-Apr-2026 00:22:02

import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers

def create_model():
    input = keras.Input(shape=(5,))
    fc1 = layers.Dense(7, name="fc1_")(input)
    tanh1 = layers.Activation('tanh')(fc1)
    fc2 = layers.Dense(12, name="fc2_")(tanh1)
    tanh2 = layers.Activation('tanh')(fc2)
    fc3 = layers.Dense(1, name="fc3_")(tanh2)

    model = keras.Model(inputs=[input], outputs=[fc3])
    return model
