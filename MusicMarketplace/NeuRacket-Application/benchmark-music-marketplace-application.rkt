#lang racket

(require "products.rkt"
         "users.rkt"
         "marketplace.rkt")


(define artist
  (new artist%
       [username "artist"]
       [password "secret"]
       [location "benchmark"]
       [birth-year 1989]
       [main-genre "pop"]
       [overarching-mood "happy"]
       [biography "Benchmark artist for album recommendation timing"]
       [to-sell '()]
       [sold '()]))

(define sample-album
  (new album%
       [title "Benchmark Album"]
       [artist artist]
       [release-year 2014]
       [genre "pop"]
       [description "Benchmark album for timing"]
       [mood "happy"]
       [languages '(english)]
       [tracks '()]))

(define user
  (new regular%
       [username "user"]
       [password "secret"]
       [location "benchmark"]
       [birth-year 2003]
       [main-genre "pop"]
       [overarching-mood "happy"]
       [biography "Benchmark user for relevant-albums timing"]
       [to-sell '()]
       [sold '()]))

(define dummy-track
  (string->path "../a-hit.wav"))

(define track
  (new track%
       [title "Benchmark Track"]
       [artist artist]
       [release-year 2014]
       [mood "happy"]
       [languages '(english)]
       [file dummy-track]))

(define digital-product
  (new digital%
       [seller "Benchmark Seller"]
       [content sample-album]
       [file "benchmark.mp3"]
       [file-kind "mp3"]))

(define physical-product
  (new physical%
       [seller "Benchmark Seller"]
       [content sample-album]
       [product-format "CD"]
       [media-condition "new"]
       [sleeve-condition "mint"]
       [stock 10]))

(define vinyl-product
  (new vinyl%
       [seller "Benchmark Seller"]
       [content sample-album]
       [media-condition "new"]
       [sleeve-condition "mint"]
       [stock 5]
       [RPM "33"]
       [size "12"]))

(define (benchmark-price-get obj x)
  (for ([i x])
    (get-field predicted-price obj)))

(define (benchmark-price-set obj x)
  (for ([i x])
    (set-field! price obj 9.99)))

(define (benchmark-recommendation-get user x)
  (for ([i x])
    (get-field relevant-albums user)))

(define (benchmark-recommendation-set user x album)
  (for ([i x])
    (send user buy-album! album)))

(define (benchmark-audio-get track x)
  (for ([i x])
    (get-field predicted-bpm track)
    (get-field predicted-genre track)
    (get-field predicted-instrument track)))

(define (benchmark-audio-set track x)
  (for ([i x])
    (set-fields! (instrument genre bpm) track ("guitar" "rock" 128))))

(define (do-benchmark-x-times x obj benchmark title)
  (displayln title)
  (do ((i 0 (+ i 1)))
    ((>= i x))
    (displayln (time (benchmark obj 100000))))) ;; als testen of werkt: op 5 zetten, anders duurt trainen te lang // anders 100000

(define (initialize-recommendation-context!)
  (send marketplace add-artist? artist)
  (send marketplace add-regular-user? user)
  (send marketplace add-album! sample-album)
  (send artist release-album! sample-album))

(define (run-benchmarks times)
  (displayln "Running price benchmark suite...")
  (do-benchmark-x-times times digital-product benchmark-price-get "Digital price inference benchmark")
  (do-benchmark-x-times times digital-product benchmark-price-set "Digital price training benchmark")
  (do-benchmark-x-times times physical-product benchmark-price-get "Physical price inference benchmark")
  (do-benchmark-x-times times physical-product benchmark-price-set "Physical price training benchmark")
  (do-benchmark-x-times times vinyl-product benchmark-price-get "Vinyl price inference benchmark")
  (do-benchmark-x-times times vinyl-product benchmark-price-set "Vinyl price training benchmark")
  (displayln "Running recommendation benchmark suite...")
  (initialize-recommendation-context!)
  (do-benchmark-x-times times user benchmark-recommendation-get "Album recommendation inference benchmark")
  (do-benchmark-x-times times user (lambda (user x) (benchmark-recommendation-set user x sample-album)) "Album recommendation training benchmark")
  (displayln "Running audio benchmark suite...")
  (do-benchmark-x-times times track benchmark-audio-get "Audio analysis inference benchmark")
  (do-benchmark-x-times times track benchmark-audio-set "Audio analysis training benchmark"))

(run-benchmarks 10)

