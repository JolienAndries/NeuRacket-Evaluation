#lang racket/base
(require "users.rkt" "products.rkt" racket/class)

(provide album-population artist-population)

(define dummy-track (string->path "../a-hit.wav"));;(string->path "/Users/jolienandries/Documents/NeuRacket/a-hit.wav"))

(define taylor-swift (new artist%
                          [username "taylor swift"]
                          [password "secret13"]
                          [location "USA"]
                          [birth-year 1989]
                          [biography "born in 1989, singer-songwriter\nsuperstar"]
                          [main-genre "pop"]
                          [overarching-mood "sad"]))

(define ts-discography `(,(new album%
                               [title "folklore"]
                               [artist taylor-swift]
                               [release-year 2020]
                               [genre "pop"]
                               [mood "sad"]
                               [tracks `(,(new track% [title "mirrorball"] [mood "sad"] [artist taylor-swift] [release-year 2020] [file dummy-track])
                                         ,(new track% [title "august"] [mood "sad"] [artist taylor-swift] [release-year 2020] [file dummy-track])
                                         ,(new track% [title "epiphany"] [mood "sad"] [artist taylor-swift] [release-year 2020] [file dummy-track]))])
                         ,(new album%
                               [title "evermore"]
                               [artist taylor-swift]
                               [release-year 2020]
                               [genre "pop"]
                               [mood "sad"]
                               [tracks `(,(new track% [title "champagne problems"] [mood "sad"][artist taylor-swift] [release-year 2020] [file dummy-track])
                                         ,(new track% [title "ivy"] [mood "sad"] [artist taylor-swift] [release-year 2020] [file dummy-track])
                                         ,(new track% [title "long story short"] [mood "sad"][artist taylor-swift] [release-year 2020] [file dummy-track]))])
                         ,(new album%
                               [title "Midnights"]
                               [artist taylor-swift]
                               [release-year 2022]
                               [genre "pop"]
                               [mood "sad"]
                               [tracks `(,(new track% [title "Maroon"] [mood "sad"][artist taylor-swift] [release-year 2022] [file dummy-track])
                                         ,(new track% [title "Bejeweled"][mood "happy"] [artist taylor-swift] [release-year 2022] [file dummy-track])
                                         ,(new track% [title "Midnight Rain"] [mood "sad"] [artist taylor-swift] [release-year 2022] [file dummy-track]))])
                         ,(new album%
                               [title "Red (Taylor's Version)"]
                               [artist taylor-swift]
                               [release-year 2021]
                               [genre "pop"]
                               [mood "sad"]
                               [tracks `(,(new track% [title "Treacherous"][mood "sad"] [artist taylor-swift] [release-year 2021] [file dummy-track])
                                         ,(new track% [title "All Too Well"][mood "sad"] [artist taylor-swift] [release-year 2021] [file dummy-track])
                                         ,(new track% [title "I Almost Do"] [mood "sad"][artist taylor-swift] [release-year 2021] [file dummy-track]))])
                         ,(new album%
                               [title "Speak Now (Taylor's Version)"]
                               [artist taylor-swift]
                               [release-year 2023]
                               [genre "pop"]
                               [mood "sad"]
                               [tracks `(,(new track% [title "Mine"][mood "happy"] [artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Sparks Fly"][mood "happy"] [artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Back to December"] [mood "sad"] [artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Speak Now"][mood "happy"] [artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Dear John"] [mood "sad"][artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Mean"] [mood "happy"][artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "The Story of Us"] [mood "angry"][artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Never Grow Up"][mood "sad"] [artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Enchanted"] [mood "happy"][artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Better than Revenge"][mood "angry"] [artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Innocent"] [mood "sad"] [artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Haunted"] [mood "sad"][artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Last Kiss"][mood "sad"] [artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Long Live"] [mood "happy"][artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Ours"] [mood "happy"][artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Superman"] [mood "happy"][artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Electric Touch"][mood "happy"] [artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "When Emma Falls in Love"] [mood "happy"][artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "I Can See You"] [mood "happy"][artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Castles Crumbling"][mood "sad"] [artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Timeless"][mood "happy"] [artist taylor-swift] [release-year 2023] [file dummy-track]))])
                         ,(new album%
                               [title "1989 (Taylor's Version)"]
                               [artist taylor-swift]
                               [release-year 2023]
                               [genre "pop"]
                               [mood "happy"]
                               [tracks `(,(new track% [title "Welcome to New York"][mood "happy"] [artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Blank Space"][mood "happy"] [artist taylor-swift] [release-year 2023] [file dummy-track])
                                         ,(new track% [title "Style"][mood "happy"] [artist taylor-swift] [release-year 2023] [file dummy-track]))])))

(for-each (lambda (album)
            (send taylor-swift release-album! album))
          ts-discography)



(define royal-blood (new artist%
                         [username "royal blood"]
                         [password "asecret"]
                         [location "UK"]
                         [birth-year 2013]
                         [main-genre "metal"]
                         [overarching-mood "angry"]))

(define rb-discography `(,(new album%
                               [title "How Did We Get So Dark?"]
                               [artist royal-blood]
                               [release-year 2017]
                               [genre "metal"]
                               [mood "sad"]
                               [tracks '()])
                         ,(new album%
                               [title "Typhoons"]
                               [artist royal-blood]
                               [release-year 2021]
                               [genre "pop"]
                               [mood "sad"]
                               [tracks `(,(new track% [title "Trouble's Coming"] [mood "happy"][artist royal-blood] [release-year 2021] [file dummy-track])
                                         ,(new track% [title "Oblivion"] [mood "happy"][artist royal-blood] [release-year 2021] [file dummy-track])
                                         ,(new track% [title "Limbo"] [mood "happy"][artist royal-blood] [release-year 2021] [file dummy-track]))])
                         ,(new album%
                               [genre "pop"]
                               [mood "sad"]
                               [title "Back To The Water Below"]
                               [artist royal-blood]
                               [release-year 2023]
                               [tracks '()])))

(for-each (lambda (album)
            (send royal-blood release-album! album))
          rb-discography)

(define sum-41 (new artist%
                    [username "Sum 41"]
                    [password "secretsums"]
                    [location "Canada"]
                    [birth-year 1996]
                    [main-genre "pop"]
                    [overarching-mood "angry"]))


(define sum41-discography `(,(new album%
                                  [title "All Killer, No Filler"]
                                  [artist sum-41]
                                  [release-year 2001]
                                  [genre "pop"]
                                  [mood "angry"]
                                  [tracks `(,(new track% [title "Fat Lip"] [mood "angry"] [artist sum-41] [release-year 2001] [file dummy-track])
                                            ,(new track% [title "In Too Deep"] [mood "angry"] [artist sum-41] [release-year 2001] [file dummy-track])
                                            ,(new track% [title "Summer"] [mood "angry"][artist sum-41] [release-year 2001] [file dummy-track]))])
                            ,(new album%
                                  [title "Does This Look Infected?"]
                                  [artist sum-41]
                                  [release-year 2002]
                                  [genre "pop"]
                                  [mood "angry"]
                                  [tracks `(,(new track% [title "Still Waiting"][mood "angry"] [artist sum-41] [release-year 2002] [file dummy-track])
                                            ,(new track% [title "The Hell Song"] [mood "angry"][artist sum-41] [release-year 2002] [file dummy-track])
                                            ,(new track% [title "Over My Head (Better Off Dead)"] [mood "angry"][artist sum-41] [release-year 2002] [file dummy-track]))])
                            ,(new album%
                                  [title "Chuck"]
                                  [artist sum-41]
                                  [genre "pop"]
                                  [mood "angry"]
                                  [release-year 2004]
                                  [tracks `(,(new track% [title "Some Say"] [mood "angry"] [artist sum-41] [release-year 2004] [file dummy-track])
                                            ,(new track% [title "Pieces"][mood "sad"] [artist sum-41] [release-year 2004] [file dummy-track])
                                            ,(new track% [title "No Reason"] [mood "angry"][artist sum-41] [release-year 2004] [file dummy-track]))])))



(for-each (lambda (album)
            (send sum-41 release-album! album))
          sum41-discography)




[define album-population (append ts-discography rb-discography sum41-discography)]
[define artist-population `(,taylor-swift ,royal-blood ,sum-41)]