#    This file was created by
#    MATLAB Deep Learning Toolbox Converter for TensorFlow Models.
#    30-Apr-2026 00:22:02

import raceTimePrediction.model
import os

def load_model(load_weights=True, debug=False):
    m = model.create_model()
    if load_weights:
        loadWeights(m, debug=debug)
    return m

## Utility functions:

import tensorflow as tf
import h5py

import sys

def loadWeights(model, filename=os.path.join(os.path.dirname(os.path.abspath(__file__)), "weights.h5"), debug=False): # changed __package__ because relative paths :/ 
    with h5py.File(filename, 'r') as f:
        # Every layer is an h5 group. Ignore non-groups (such as /0)
        for g in f:
            if isinstance(f[g], h5py.Group):
                group = f[g]
                layerName = group.attrs['Name']
                numVars = int(group.attrs['NumVars'][0]) # added [0] - TypeError: only 0-dimensional arrays can be converted to Python scalars
                if debug:
                    print("layerName:", layerName)
                    print("    numVars:", numVars)
                # Find the layer index from its namevar
                layerIdx = layerNum(model, layerName)
                layer = model.layers[layerIdx]
                if debug:
                    print("    layerIdx=", layerIdx)
                # Every weight is an h5 dataset in the layer group. Read the weights 
                # into a list in the correct order
                weightList = [0]*numVars
                for d in group:
                    dataset = group[d]
                    varName = dataset.attrs['Name']
                    shp     = intList(dataset.attrs['Shape'])
                    weightNum = int(dataset.attrs['WeightNum'][0]) # added [0] - TypeError: only 0-dimensional arrays can be converted to Python scalars
                    # Read the weight and put it into the right position in the list
                    if debug:
                        print("    varName:", varName)
                        print("        shp:", shp)
                        print("        weightNum:", weightNum)
                    weightList[weightNum] = tf.constant(dataset[()], shape=shp)
                # Assign the weights into the layer
                for w in range(numVars):
                    if debug:
                        print("Copying variable of shape:")
                        print(weightList[w].shape)
                    layer.variables[w].assign(weightList[w])
                    if debug:
                        print("Assignment successful.")
                        print("Set variable value:")
                        print(layer.variables[w])
                # Finalize layer state
                if hasattr(layer, 'finalize_state'):
                    layer.finalize_state()

def layerNum(model, layerName):
    # Returns the index to the layer
    layers = model.layers
    for i in range(len(layers)):
        if layerName==layers[i].name:
            return i
    print("")
    print("WEIGHT LOADING FAILED. MODEL DOES NOT CONTAIN LAYER WITH NAME: ", layerName)
    print("")
    return -1

def intList(myList): 
    # Converts a list of numbers into a list of ints.
    return list(map(int, myList))

