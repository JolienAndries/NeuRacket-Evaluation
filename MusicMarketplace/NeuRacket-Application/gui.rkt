#lang racket/base
(require racket/gui (only-in racket/math exact-round))
(require "products.rkt"  "marketplace.rkt" "users.rkt" "Enum-Information.rkt" (only-in racket/stream stream->list))
(define application-frame (new frame% [label "Application"]))

;;;;;;;;;;;;;;;;;;;  helpers ;;;;;;;;;;;;;;;;;;; 

(define (is-child? child parent)
  (member child (send parent get-children)))

(define (only-show-list-panels frame lst)
  (send frame change-children (lambda (children) 
                                (append (take children 2) ;; visible vs invisible
                                        lst))))


(define (clear-single-selection box)
  (let ((selected (send box get-selection)))
    (when selected
      (send box select selected #f))))

(define (get-single-selection-selections choices choice-box)
  (let ((selection (send choice-box get-selection)))
    (if selection 
        (list-ref choices selection)
        #f)))


;;;;;;;;;;;;;;;;;;;;;; start ;;;;;;;;;;;;;;;;;;;;;;

(define login-register-dialog (new dialog% [label "welcome"]
                                   [parent application-frame]))
(new message% [parent login-register-dialog] 
     [label "What do you want to do?"])

(new choice%
     [label "Pick One" ]
     [choices '("Login" "Register")]
     [parent login-register-dialog]
     [callback (lambda (choice event)
                 (let ((idx (send choice get-selection))
                       (vec (vector
                             ;; login
                             `(,login-panel)
                             ;; register
                             `(,register-panel))))
                   (only-show-list-panels login-register-dialog (vector-ref vec idx))))])



;;;;;;;;;;;;;;;;;;;;;; register user panel ;;;;;;;;;;;;;;;;;;;;;;
(define register-panel (new vertical-panel% [parent login-register-dialog]))

(define name-field (new text-field%
                        [label "Name"]
                        [parent register-panel]))

(define password-field (new text-field%
                            [label "Password"]
                            [parent register-panel]
                            [style '(single password)]))

(define biography-field (new text-field%
                             [label "Biography"]
                             [parent register-panel]
                             [min-width 300]))


(define location-choice (new choice%
                             [label "Location"]
                             [parent register-panel]
                             [choices location-choices]))


(define genre-preference-box (new list-box%
                                  [parent register-panel]
                                  [choices genre-choices]
                                  [style '(single)]
                                  [label "Favourite Genre"]
                                  [min-width 300]))
(define mood-preference-box (new list-box%
                                 [parent register-panel]
                                 [choices mood-choices]
                                 [style '(single)]
                                 [label "Favourite Mood"]
                                 [min-width 300]))

(define age-choices (stream->list (in-range 1920 2015)))
(define age-choice (new choice%
                        [label "Year of Birth"]
                        [parent register-panel]
                        [choices (map number->string age-choices)]))


(define artist-checkbox (new check-box%
                             [label "I am an artist"]
                             [parent register-panel]))

(define register-button
  (new button%
       [label "Register"]
       [parent register-panel]
       [callback
        (lambda (button event)
          (let* ((name (send name-field get-value))
                 (password (send password-field get-value))
                 (biography (send biography-field get-value)) ;; can be empty
                 (location (list-ref location-choices (send location-choice get-selection)))
                 (age (list-ref age-choices (send age-choice get-selection)))
                 (genre (get-single-selection-selections genre-choices genre-preference-box))
                 (mood (get-single-selection-selections mood-choices mood-preference-box))
                 (is-artist? (send artist-checkbox get-value)))
            (when (and (not (string=? name ""))
                       (not (string=? password ""))
                       (not (null? location))
                       mood
                       genre)
              ;; ugly code
              (let ((added? (if is-artist?
                                (send marketplace add-artist? (new artist%
                                                                   [username name] [password password] [location location] [birth-year age] [main-genre genre] [overarching-mood mood] [biography biography]))
                                (send marketplace add-regular-user? (new regular%
                                                                         [username name] [password password] [location location] [birth-year age] [main-genre genre] [overarching-mood mood] [biography biography])))))

                (if added?
                    (send login-register-dialog show #f)
                    (new message% [parent register-panel] 
                         [label "User with same name exists already."]))))))]))


;;;;;;;;;;;;;;;;;;;;;; login user panel ;;;;;;;;;;;;;;;;;;;;;;
(define login-panel (new vertical-panel% [parent login-register-dialog]))

;; Name and password fields
(define login-name-field (new text-field%
                              [label "Name"]
                              [parent login-panel]))

(define login-password-field (new text-field%
                                  [label "Password"]
                                  [parent login-panel]
                                  [style '(single password)]))


(define login-button
  (new button%
       [label "Login"]
       [parent login-panel]
       [callback
        (lambda (button event)
          (let* ((name (send login-name-field get-value))
                 (password (send login-password-field get-value)))
            (when (and (not (string=? name ""))
                       (not (string=? password "")))
              (if (send marketplace log-in-if-possible? name password)
                  (send login-register-dialog show #f)
                  (new message% [parent login-panel] 
                       [label "Wrong username or password."])))))]))


;;;;;;;;;;;;;;;;;;;;;;  selling frame  ;;;;;;;;;;;;;;;;;;;;;;


;; explanation
(new message% [parent application-frame] 
     [label "What do you want to do?"])

(define (refreshed-pick-existing-albums)
  (send pick-existing-album set '())
  (for-each (lambda (album)
              (send pick-existing-album append (string-append (vector-ref album 0) " - " (vector-ref album 1)) album))
            (get-field relevant-albums (get-field current-user marketplace))) ;; <- 
  pick-existing-album)

;; pick category
(new choice%
     [label "Category" ]
     [choices '("Sell Album" "Add New Album" "Browse Albums" "Log Out")]
     [parent application-frame]
     [callback (lambda (choice event)
                 (let ((idx (send choice get-selection))
                       (vec (vector
                             ;; sell album
                             (thunk `(,(refreshed-pick-existing-albums) ,music-selling-panel))
                             ;; new album
                             (thunk `(,add-music-panel))
                             ;; browse albums
                             (thunk  `(,(refreshed-pick-existing-albums)))
                             ;; log out
                             (thunk   (begin (send marketplace log-out!) (send login-register-dialog show #t) '())))))
                   (only-show-list-panels application-frame ((vector-ref vec idx)))))]) 


;;;;;;;;;;;;;;;;;;;;;; add album  ;;;;;;;;;;;;;;;;;;;;;;


(define add-music-panel (new horizontal-panel% [parent application-frame]))
(define music-left (new vertical-panel% [parent add-music-panel]))
(define track-panel (new vertical-panel% [parent add-music-panel]))


(define title-field (new text-field%
                         [label "Title"]
                         [parent music-left]))

(define artist-listbox
  (new list-box%
       [label "Artist"]
       [parent music-left]
       [choices '()]
       [style '(single)]
       [min-width 200]))
(for-each (lambda (artist)
            (send artist-listbox append (get-field username artist) artist))
          (get-field artists marketplace))



(define songwriter-field (new text-field% 
                              [label "Songwriter"]
                              [parent music-left]))
(define producer-field (new text-field%
                            [label "Producer"]
                            [parent music-left]))
(define release-year-field (new text-field%
                                [label "Release Year"]
                                [parent music-left]))
(define description-field (new text-field%
                               [label "Description"]
                               [parent music-left]))


(define genre-box (new list-box%
                       [parent music-left]
                       [choices genre-choices]
                       [style '(single)]
                       [label "Genres"]
                       [min-width 300]))


(define mood-box (new list-box%
                      [parent music-left]
                      [choices mood-choices]
                      [style '(single)]
                      [label "Mood"]
                      [min-width 300]))


(define language-box (new list-box%
                          [parent music-left]
                          [choices language-choices]
                          [style '(single)]
                          [label "Language"]
                          [min-width 300]))

;; track panel content 
(define track-list '())
(define titles '())
(define track-list-box
  (new list-box%
       [parent track-panel]
       [choices track-list]
       [style '(single vertical-label)]
       [label "Tracks"]
       [min-width 300]
       [min-height 300]))

(define add-track-button (new button%
                              [parent track-panel]
                              [label "Add Track"]
                              ; Callback procedure for a button click:
                              [callback (lambda (button event)
                                          (send track-pop-up show #t))]))

(define (get-selected-choices-from-box lbox choices)
  (map (lambda (idx)
         (list-ref choices idx))
       (send lbox get-selections))
  (send lbox get-selections))


(define selected-album #f) ;; global variables = bad idea

(new button% [parent music-left]
     [label "Add Album!"]
     ; Callback procedure for a button click:
     [callback (lambda (button event)
                 (let ((title (send title-field get-value))
                       (artist-idx (send artist-listbox get-selection))
                       (songwriter (send songwriter-field get-value))
                       (producer (send producer-field get-value))
                       (release-year (string->number (send release-year-field get-value)))
                       (description (send description-field get-value))
                       (chosen-genre (get-single-selection-selections genre-choices genre-box))
                       (chosen-mood (get-single-selection-selections mood-choices mood-box))
                       (languages (get-selected-choices-from-box language-box language-choices))
                       (tracks track-list))
                   
                    
                   (if (or (string=? title "")
                           (not artist-idx)
                           (string=? songwriter "")
                           (string=? producer "")
                           (not release-year)
                           (string=? description "")
                           (not chosen-genre)
                           (not chosen-mood)
                           (null? languages)
                           (null? tracks))
                       (new message% [parent music-left] [label "Something is missing"])
                       (let ((new-album (new album%
                                             [title title]
                                             [artist (send artist-listbox get-data artist-idx)]
                                             [release-year release-year]
                                             [description description]
                                             [genre chosen-genre]
                                             [mood chosen-mood]
                                             [languages languages]
                                             [tracks tracks])))
                         (set! track-list '())
                         (send marketplace add-album! new-album)
                         (set! selected-album new-album)
                         (set-album-panel! new-album)
                         (only-show-list-panels application-frame `(,specific-album-panel))))))])

;;;;;;;;;;;;;;;;;;;;;; pick existing album ;;;;;;;;;;;;;;;;;;;;;;

(define pick-existing-album (new list-box%
                                 [parent application-frame]
                                 [choices '()] ;; wordt hierboven verandert bij selectie
                                 [callback (lambda (box event)
                                             (let ((selected (send box get-selections)))
                                               (unless (null? selected)
                                                 (let* ((album-title-artist (send box get-data (car selected))) ;; car ok want altijd null of 1 elem want single style
                                                        (album (send marketplace find-album (vector-ref album-title-artist 0) (vector-ref album-title-artist 1))))
                                                   (set-album-panel! album)
                                                   (set! selected-album album)
                                                   ;; vervang picking panel door specifiek album panel
                                                   (send application-frame change-children (lambda (children) 
                                                                                             (map (lambda (child)
                                                                                                    (if (eq? pick-existing-album child)
                                                                                                        specific-album-panel
                                                                                                        child))
                                                                                                  children)))))))]
                                 [style '(single)]
                                 [label "Album"]
                                 [min-width 100]))


;;;;;;;;;;;;;;;;;;;;;; music products ;;;;;;;;;;;;;;;;;;;;;;

(define music-selling-panel (new vertical-panel% [parent application-frame]))

(define selling-pop-up (new dialog% [label "Add Product"] [parent application-frame]))
(define selling-panel (new vertical-panel% [parent selling-pop-up]))


;; all different panels for information

(define (show-digital-panel album)
  (send selling-panel change-children
        (lambda (children)
          (define file-kind-choices '("mp3" "wav"))
          (define file-kind-choice
            (new choice% [label "File kind"] [choices file-kind-choices] [parent selling-panel]))
          (define file-path #f)
          (define file-msg (new message% [parent selling-panel] [label "No file uploaded yet"]))
          
          (list
           ;; button
           (new button% [parent selling-panel]
                [label "Add File"]
                [callback (lambda (b e)
                            (set! file-path (get-file))
                            (when file-path
                              (send file-msg set-label (path->string file-path))))])
           file-msg
           file-kind-choice
           (new button% [parent selling-panel]
                [label "Next"]
                [callback  (lambda (button event)
                             (if (and file-path
                                      (not (null? (send file-kind-choice get-selection))))
                                 (let ((product (new digital%
                                                     [seller (get-field current-user marketplace)]
                                                     [content album]
                                                     [file file-path]
                                                     [file-kind (get-single-selection-selections file-kind-choices file-kind-choice)])))
                                   (open-price-tab album product))
                                 (new message% [label "Missing Fields - Please select a file and a file kind before continuing."] [parent selling-panel])))])))))



(define (show-vinyl-panel album)
  (send selling-panel change-children
        (lambda (children)
          
          (define media-cond-choice (new choice% [label "Media Condition"] [choices condition-choices] [parent selling-panel]))
          (define sleeve-cond-choice (new choice% [label "Sleeve Condition"] [choices condition-choices] [parent selling-panel]))
          (define stock (new text-field% [label "How many do you want to sell?"] [parent selling-panel]))

          (define rpm-choice (new choice% [label "RPM"] [choices rpm-choices] [parent selling-panel]))
          (define size-choice (new choice% [label "Size"] [choices size-choices] [parent selling-panel]))

          
          (list
           media-cond-choice
           sleeve-cond-choice
           stock
           rpm-choice
           size-choice
           (new button% [parent selling-panel]
                [label "Next"]
                [callback (lambda (button event) 
                            (let ((media-cond-selection (get-single-selection-selections condition-choices media-cond-choice))
                                  (sleeve-cond-selection (get-single-selection-selections condition-choices sleeve-cond-choice))
                                  (stock-val (string->number (send stock get-value)))
                                  (rpm-selection (get-single-selection-selections rpm-choices rpm-choice))
                                  (size-selection (get-single-selection-selections size-choices size-choice)))
                              (if (and media-cond-selection
                                       sleeve-cond-selection
                                       stock-val
                                       rpm-selection
                                       size-selection)
                                  (let ((product (new vinyl%
                                                      [seller (get-field current-user marketplace)]
                                                      [content album]
                                                      [media-condition media-cond-selection]
                                                      [sleeve-condition sleeve-cond-selection]
                                                      [stock stock-val]
                                                      [RPM rpm-selection]
                                                      [size size-selection])))
                                    (open-price-tab album product))

                                  (new message% [label "Missing Fields - Please fill everything in before continuing."] [parent selling-panel]))))])))))




(define (show-physical-panel album format)
  (send selling-panel change-children
        (lambda (children)
          (define media-cond-choice (new choice% [label "Media Condition"] [choices condition-choices] [parent selling-panel]))
          (define sleeve-cond-choice (new choice% [label "Sleeve Condition"] [choices condition-choices] [parent selling-panel]))
          (define stock (new text-field% [label "How many do you want to sell?"] [parent selling-panel]))
          (list
           media-cond-choice
           sleeve-cond-choice
           stock
           (new button% [parent selling-panel]
                [label "Next"]
                [callback (lambda (button event) 
                            (let ((media-cond-selection (get-single-selection-selections condition-choices media-cond-choice))
                                  (sleeve-cond-selection (get-single-selection-selections condition-choices sleeve-cond-choice))
                                  (stock-val (string->number (send stock get-value))))
                              (if (and media-cond-selection
                                       sleeve-cond-selection
                                       stock-val)
                                  (let ((product (new physical%
                                                      [seller (get-field current-user marketplace)]
                                                      [content album]
                                                      [media-condition media-cond-selection]
                                                      [sleeve-condition sleeve-cond-selection]
                                                      [product-format format]
                                                      [stock stock-val])))
                                    (open-price-tab album product))

                                  (new message% [label "Missing Fields - Please fill everything in before continuing."] [parent selling-panel]))))])))))


(define (open-price-tab album product)
  (send selling-panel change-children
        (lambda (children)
          (define suggested-price (get-field predicted-price product)) 
          (define manual-price (new text-field% [label "Change price"] [parent selling-panel]))
          (define (add-product! product chosen-price)
            (send marketplace sell-product! product)
            (set-field! price product chosen-price)
            (send selling-pop-up show #f))
          
          (list
           (new message% [label (string-append "Suggested price: " (number->string suggested-price))]
                [parent selling-panel])
           (new button% [parent selling-panel]
                [label "Accept price"]
                [callback (lambda (b e)
                            (add-product! product suggested-price))])
           manual-price
           (new button% [parent selling-panel]
                [label "Sell for a custom price"]
                [callback (lambda (b e)
                            (let ((manual-price (string->number (send manual-price get-value))))
                              (if manual-price
                                  (add-product! product manual-price) 
                                  (new message% [label "Missing Fields - Please fill in a custom price if you want to have a custom price."] [parent selling-panel]))))])))))


;; format to sell
(define format-box
  (new list-box%
       [parent music-selling-panel]
       [choices '()]
       [style '(extended vertical-label)]
       [callback (lambda (listbox event)
                   (let ((selected (send listbox get-selections)))
                     (unless (or (null? selected) (not selected-album))
                       (let ((panel-function (send listbox get-data (car selected)))
                             (format (list-ref format-choices (car selected))))
                         (panel-function selected-album format)
                         (send selling-pop-up show #t)))))]
       [label "Formats"]
       [min-width 50]))
;; format + correct pop up 
(for-each (lambda (format function)
            (send format-box append format function))
          format-choices
          (list
           (lambda (album format) (show-digital-panel album))
           (lambda (album format) (show-vinyl-panel album))
           show-physical-panel
           show-physical-panel))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; adding a track panel ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define track-pop-up (new dialog% [label "Add Track"]
                          [parent application-frame]))




(define (track-added-clear-all!)
  ;; clear basic info
  (send track-title set-value "")
  (send track-year set-value "")
  (send track-message set-label "no track uploaded yet")
  (set! track-file-path #f) 
  ;; put basic info back as pop up start
  (send track-pop-up change-children (lambda (children) `(,track-basic-info-panel)))
  ;; close pop up 
  (send track-pop-up show #f))

;;;;;;;;;;;;;;;;;;;;; basic info ;;;;;;;;;;;;;;;;;;;;;;;
(define track-basic-info-panel (new vertical-panel% [parent track-pop-up]))

(define track-title (new text-field%
                         [label "Title"]
                         [parent track-basic-info-panel]))

(define track-artist
  (new list-box%
       [label "Artist"]
       [parent track-basic-info-panel]
       [choices '()]
       [style '(single)]
       [min-width 200]))
(for-each (lambda (artist)
            (send track-artist append (get-field username artist) artist))
          (get-field artists marketplace))
(define track-year (new text-field%
                        [label "Release year"]
                        [parent track-basic-info-panel]))
(define track-mood (new list-box%
                        [parent track-basic-info-panel]
                        [choices mood-choices]
                        [style '(single)]
                        [label "Track Mood"]
                        [min-width 300]))
(define track-file-path #f)
(new button%
     [parent track-basic-info-panel]
     [label "Add File"]
     ; Callback procedure for a button click:
     [callback (lambda (button event)
                 (set! track-file-path (get-file))
                 (when track-file-path
                   (send track-message set-label (path->string track-file-path))))])

(define track-message (new message%
                           [parent track-basic-info-panel]
                           [label "no track uploaded yet"]))


(new button% 
     [parent track-basic-info-panel]
     [label "Next"]
     [callback  (lambda (button event)
                  ;; get the values 
                  (let ((title (send track-title get-value))
                        (artist-idx (send track-artist get-selection))
                        (year (string->number (send track-year get-value)))
                        (track-mood (get-single-selection-selections mood-choices track-mood))
                        (track-path  track-file-path))
                    
                    ;; check that everything is filled in
                    (unless (or (string=? title "")
                                (not artist-idx)
                                (not track-mood)
                                (not year)
                                (not track-path))
                      (let ((new-track (new track% [title title]
                                            [artist (send track-artist get-data artist-idx)]
                                            [mood track-mood]
                                            [release-year year]
                                            [file track-file-path])))
                       
                        ;; remove basic information from pop up and show song analysis
                        (send track-pop-up change-children (lambda (children) `(,(updated-track-analysis-panel new-track))))))))])


;;;;;;;;;;;;;;;;;;;; song analysis ;;;;;;;;;;;;;;;;;;;;;;;;


(define track-analysis-panel (new vertical-panel% [parent track-pop-up]))
(define change-analysis-pop-up (new dialog% [label "Change Analysis"] [parent application-frame]))
(define change-analysis-panel (new vertical-panel% [parent change-analysis-pop-up] [min-width 500]))

(define (updated-track-analysis-panel new-track)
  (send track-analysis-panel change-children
        (lambda (children)
          (let ((proposed-bpm (get-field predicted-bpm new-track))
                (proposed-genre  (get-field predicted-genre new-track))
                (proposed-instrument (get-field predicted-instrument new-track)))
            ;; propose
            (define track-genre-proposed
              (new message% [parent track-analysis-panel]
                   [label (string-append "Analysed genre is: "   proposed-genre)]))
            (define track-instrument-proposed
              (new message% [parent track-analysis-panel]
                   [label (string-append "Analysed instrument is: "
                                         proposed-instrument)]))
            (define track-BPM-proposed
              (new message% [parent track-analysis-panel]
                   [label (string-append "Analysed BPM is: "
                                         (number->string (exact-round proposed-bpm)))]))
            (define (make-button label-msg specific-choices choice-label when-selected)
              (new button% 
                   [parent track-analysis-panel]
                   [label label-msg]
                   [callback
                    (lambda (button event)
                      (define track-box
                        (new list-box%
                             [parent change-analysis-panel]
                             [choices specific-choices]
                             [style '(single)]
                             [label choice-label]
                             [min-width 300]))
                      (send change-analysis-panel change-children
                            (lambda (children)
                              `(,track-box
                                ,(new button% [parent change-analysis-panel]
                                      [label "Change!"]
                                      [callback
                                       (lambda (button event)
                                         (let ((selected
                                                (get-single-selection-selections
                                                 specific-choices track-box)))
                                           (if selected 
                                               (begin
                                                 (when-selected selected)
                                                 (send change-analysis-pop-up show #f))
                                               (new message%
                                                    [parent change-analysis-panel]
                                                    [label "Select something"]))))]))))
                      (send change-analysis-pop-up show #t))]))
            
            (list
             track-genre-proposed
             (make-button "Change Genre" genre-choices "Genres"
                          (lambda (selected)
                            (set! proposed-genre selected)
                            (send track-genre-proposed set-label
                                  (string-append "Genre: " selected))))
             track-instrument-proposed
             (make-button "Change Instrument" track-instrument-choices "Instruments"
                          (lambda (selected)
                            (set! proposed-instrument  selected)
                            (send track-instrument-proposed set-label
                                  (string-append "Instrument: " selected))))
             track-BPM-proposed
             (new button% 
                  [parent track-analysis-panel]
                  [label "Change BPM"]
                  [callback
                   (lambda (button event)
                     (define track-tempo (new text-field%
                                              [label "BPM"]
                                              [parent change-analysis-panel]))
                     (send change-analysis-panel change-children
                           (lambda (children)
                             `(,track-tempo
                               ,(new button% [parent change-analysis-panel]
                                     [label "Change!"]
                                     [callback
                                      (lambda (button event)
                                        (let ((bpm-number
                                               (string->number
                                                (send track-tempo get-value))))
                                          (if bpm-number
                                              (begin
                                                (set! proposed-bpm bpm-number)
                                                (send track-BPM-proposed set-label
                                                      (string-append
                                                       "BPM: "
                                                       (send track-tempo get-value)))
                                                (send change-analysis-pop-up show #f))
                                              (new message% [parent change-analysis-panel]
                                                   [label "Write a number"]))))]))))
                     (send change-analysis-pop-up show #t))])

             (new button%
                  [parent track-analysis-panel]
                  [label "Confirm"]
                  [callback
                   (lambda (button event)
                     ;; update track properties
                     (set-fields! (instrument genre bpm)
                                  new-track
                                  (proposed-instrument
                                   proposed-genre
                                   proposed-bpm))
                     ;; add the track to the track list
                     (set! track-list (cons new-track
                                            track-list))
                     (set! titles (cons (get-field title new-track) titles))
                     (send track-list-box set (reverse titles))
                     (track-added-clear-all!))])))))
  track-analysis-panel)

;; to start only show basic info:
(send track-pop-up change-children (lambda (children) `(,track-basic-info-panel)))

;;;;;;;;;;;;;;;;;;;;;; album ;;;;;;;;;;;;;;;;;;;;;;


(define specific-album-panel (new vertical-panel% [parent application-frame]))
(define (set-album-panel! album)
  (define track-list-box
    (new list-box%
         [parent specific-album-panel]
         [label "Tracks"]
         [style '(single)]
         [choices '()]
         [min-width 100]
         [callback (lambda (lb event)
                     (let* ((idx (send lb get-selection))
                            (track (send lb get-data idx))) 
                       (show-track-panel track)))]))
  (for-each (lambda (track)
              (send track-list-box append (get-field title track) track))
            (get-field tracks album))



  (send specific-album-panel change-children (lambda (children) 
                                               ;; voeg de dingen van de artiest toe
                                               (define products-list-box (new list-box%
                                                                              [parent specific-album-panel]
                                                                              [choices '()] 
                                                                              [style '(single)]
                                                                              [label "How you can buy this album"]
                                                                              [min-width 100]
                                                                              [callback (lambda (lbox event)
                                                                                          (let ((idx (send lbox get-selection)))
                                                                                            
                                                                                            (unless (null? idx)
                                                                                              (let ((product (send lbox get-data  idx)))
                                                                                                (show-product-page product)))))]))
                                               (for-each (lambda (product)
                                                           (send products-list-box append
                                                                 (string-append (get-field product-format product) " - €" (number->string (get-field price product)))
                                                                 product))
                                                         (get-field selling-formats album))


                                               `(,(new message% [parent specific-album-panel]
                                                       [label "Title"])
                                                 ,(new message% [parent specific-album-panel]
                                                       [label (get-field title album)])
                                                 ,(new message% [parent specific-album-panel]
                                                       [label "Artist"])
                                                 ,(new button%
                                                       [parent specific-album-panel]
                                                       [label (get-field username (get-field artist album))]
                                                       [callback (lambda (button event)
                                                                   (set-artist-panel! (get-field artist album))
                                                                   (only-show-list-panels application-frame `(,specific-artist-panel)))])
                                                 ,(new message% [parent specific-album-panel]
                                                       [label (string-append "Release Year\t" (number->string (get-field release-year album)))])
                                                 ,track-list-box
                                                 ,products-list-box))))


;;;;;;;;;;;;;;;;;;; track ;;;;;;;;;;;;;;;;;;;

(define specific-track-panel (new vertical-panel% [parent application-frame]))

(define (show-track-panel track)
  (define maybe-no-play (new message% [label ""] [parent specific-track-panel]))
  (let ((track-artist (get-field artist track)))
    (send specific-track-panel change-children
          (lambda (children)
            `(,(new message% [parent specific-track-panel] [label "Title"])
              ,(new message% [parent specific-track-panel]
                    [label (get-field title track)])

              ,(new message% [parent specific-track-panel] [label "Artist"])
              ,(new button%
                    [parent specific-track-panel]
                    [label (get-field username track-artist)]
                    [callback
                     (lambda (button event)
                       (set-artist-panel! track-artist)
                       (only-show-list-panels application-frame
                                              `(,specific-artist-panel)))])

              ,(new message% [parent specific-track-panel]
                    [label
                     (string-append "Release Year\t"
                                    (number->string (get-field release-year track)))])

              ,(new button% [label "Play Preview"]
                    [parent specific-track-panel]
                    [callback
                     (lambda (button event)
                       (unless (play-sound (get-field file track) #t)
                         (send maybe-no-play set-label
                               "Audio track could not play")))])
              
              ,maybe-no-play

              ,(new message%
                    [parent specific-track-panel]
                    [label  "Analysis:"])

              ,(new message%
                    [parent specific-track-panel]
                    [label
                     (string-append "Instrument: "  (let ((instrument (get-field instrument track)))
                                                      (if instrument instrument (get-field predicted-instrument track))))])
                                               

              ,(new message%
                    [parent specific-track-panel]
                    [label (string-append "Genre: "  (let ((genre (get-field genre track)))
                                                       (if genre genre (get-field predicted-genre track))))])
                                               

              ,(new message%
                    [parent specific-track-panel]
                    [label
                     (string-append "BPM: "
                                    (number->string (let ((bpm (get-field bpm track)))
                                                      (if bpm bpm (get-field predicted-bpm track)))))])))))
  (only-show-list-panels application-frame `(,specific-track-panel))) 



;;;;;;;;;;;;;;;;;;;;;; artist ;;;;;;;;;;;;;;;;;;;;;;

(define specific-artist-panel (new vertical-panel% [parent application-frame]))
(define (set-artist-panel! artist)
  ;; clear panel
  (send specific-artist-panel change-children (lambda (children) '()))
  ;; voeg de dingen van de artiest toe
  (new message% [parent specific-artist-panel]
       [label (string-append "Name\t" (get-field username artist))])
  (new message% [parent specific-artist-panel]
       [label (string-append "Biography\n" (get-field biography artist))])
  (define discography-box (new list-box%
                               [parent specific-artist-panel]
                               [choices  '()]
                               [style '(single)]
                               [label "Discography"]
                               [callback (lambda (box event)
                                           (let ((selected (send box get-selections)))
                                             (unless (null? selected)
                                               (let ((album (send box get-data (car selected)))) ;; car ok want altijd null of 1 elem want single style 
                                                 (set-album-panel! album)
                                                 (only-show-list-panels application-frame `(,specific-artist-panel ,specific-album-panel))))))]
                               [min-width 100]))
  (for-each (lambda (album)
              (send discography-box append (get-field title album) album))
            (get-field discography artist)))



(only-show-list-panels application-frame '())
(only-show-list-panels login-register-dialog '())
; Show the frame by calling its show method
(send application-frame show #t)
(send login-register-dialog show #t) ;; first log in 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;; specific product page ;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define specific-product-panel (new vertical-panel% [parent application-frame]))

(define (show-product-page product)
  (define maybe-no-play (new message% [label ""] [parent specific-product-panel]))
  (define buy-button-msg (new message% [label "Not Yet Bought"] [min-width 300] [parent specific-product-panel]))
  (send specific-product-panel change-children
        (lambda (children)
          (define content (get-field content product))
          (define artist (get-field artist content))
          (append
           ;; standaard 
           `(,(new message% [parent specific-product-panel] [label (string-append "Title: " (get-field title content))])
             ,(new message% [parent specific-product-panel] [label  "Artist:"])
             ,(new button%
                   [parent specific-product-panel]
                   [label (get-field username artist)]
                   [callback (lambda (btn evt)
                               (set-artist-panel! artist)
                               (only-show-list-panels application-frame `(,specific-artist-panel)))])
              
             ,(new message% [parent specific-product-panel] [label (string-append "Format: " (get-field product-format product))])
             ,(new message% [parent specific-product-panel] [label (string-append "Price: €" (number->string (get-field price product)))])) ; <- 
           ;; physical 
           (if (is-a? product physical%)
               `(,(new message% [parent specific-product-panel]
                       [label (string-append "Media Condition: " (get-field media-condition product))])
                 ,(new message% [parent specific-product-panel]
                       [label (string-append "Sleeve Condition: " (get-field sleeve-condition product))])
                 ,(new message% [parent specific-product-panel]
                       [label (string-append "Stock: " (number->string (get-field stock product)))]))
               '())
           ;; vinyl
           (if (is-a? product vinyl%)
               `(,(new message% [parent specific-product-panel]
                       [label (string-append "RPM: "  (get-field RPM product))])
                 ,(new message% [parent specific-product-panel]
                       [label (string-append "Size: " (get-field size product))]))
               '())
           ;; digital
           (if (is-a? product digital%)
               `(,(new message% [parent specific-product-panel]
                       [label (string-append "File Kind: " (get-field file-kind product))])
                 ,(new button% [label "Play Preview"]
                       [parent specific-product-panel]
                       [callback (lambda (btn evt)
                                   (unless (play-sound (get-field file product) #t)
                                     (send maybe-no-play set-label "Could not play file")))])
                 ,maybe-no-play)
               '())
           (list (new button%
                      [label "Buy"]
                      [parent specific-product-panel]
                      [callback (lambda (btn evt)
                                  (if (send marketplace buy-product! product)
                                      (send buy-button-msg set-label "Purchase successful!")
                                      (send buy-button-msg set-label "Could not buy")))])
                 buy-button-msg))))

  (only-show-list-panels application-frame `(,specific-product-panel)))


