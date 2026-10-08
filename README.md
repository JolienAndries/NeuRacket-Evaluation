# NeuRacket-Evaluation

These are the evaluation scenarios for the programming language [NeuRacket](https://github.com/JolienAndries/NeuRacket) (an extension of Racket). 

## The branches 
- The `label-field` branch are the standard implementations for the driver scenarios, on which the LOC counting happened. 
- The `training-intensity` branch is the extension scenario for adding training intensity to the runner activity tracker
- the `on-sale-product` branch is the extension scenario for putting a product on sale in the music marketplace

## How to use

To run the MusicMarketplace and the RunnerActivityTracker, move to the correct folder and:
- in the `NeuRacket-Application` directory, run `neuracket gui.rkt`
- in the `Racket-Application` directory, run `racket gui.rkt`

Important: 
- In order to be able to run `neuracket gui.rkt`, you must first download and compile [NeuRacket](https://github.com/JolienAndries/NeuRacket), and alias `neuracket` to `...path.../NeuRacket/racket/bin/racket`
- NeuRacket must be configured to use a Python installation that has access to the necessary libraries for the machine learning models.
- The runner activity tracking application needs two additional racket packages, `euclid` and `map-widget`. Install these using `...path.../NeuRacket/racket/bin/raco pkg install <pkg-name>`

## Side Info
- We provide an example a-hit.wav for the MusicMarketplace to add a song in the application.
- We provide an example example.gpx for the RunnerActivityTracker to add a workout in the application.