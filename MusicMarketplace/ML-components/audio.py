#import sys
#import pprint
#import os
#print("current working directory, ", os.getcwd())
#print("Executable:", sys.executable)
#print("Sys.path:")
#pprint.pprint(sys.path)

from transformers import pipeline
import torchaudio
import librosa

import csv
import os

print("AUDIO MODEL")

data_filename = "../../../training_data_audio.csv"
# https://huggingface.co/dima806/music_genres_classification
RATE_HZ = 16000 # resampling rate in Hz
MAX_LENGTH = 240000 # maximum audio interval length to consider (= RATE_HZ * SECONDS)


def get_highest_score_label(predictions):
    if not predictions:
        return None  
    highest = max(predictions, key=lambda x: x['score'])
    return highest['label']


def infer(file_path):
    # general 
    # https://huggingface.co/dima806/music_genres_classification
    audio,rate=torchaudio.load(file_path)
    transform_audio =torchaudio.transforms.Resample(rate,RATE_HZ)
    audio = transform_audio(audio).numpy().reshape(-1)[:MAX_LENGTH]

    # https://huggingface.co/dima806/music_genres_classification
    pipe_genre = pipeline("audio-classification", model="dima806/music_genres_classification")
    genre = pipe_genre(audio)
    genre = get_highest_score_label(genre)

    # https://huggingface.co/dima806/musical_instrument_detection
    pipe_instrument = pipeline("audio-classification", model="dima806/musical_instrument_detection")
    instrument = pipe_instrument(audio)
    instrument = get_highest_score_label(instrument)


    # BPM
    # https://librosa.org/doc/main/generated/librosa.beat.beat_track.html
    y, sr = librosa.load(file_path)
    [bpm], beats = librosa.beat.beat_track(y=y, sr=sr) # bpm is a numpy float

    return (genre, instrument, bpm.item())

def train(file_path, genre, instrument, bpm):
    # store in training file for next retrain 
    # https://www.geeksforgeeks.org/writing-csv-files-in-python/
    file_exists = os.path.isfile(data_filename)
    with open(data_filename, mode='a', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        if not file_exists:
            writer.writerow(['FilePath', 'Genre', 'Instrument', 'BPM'])
        writer.writerow([file_path, genre, instrument, bpm])