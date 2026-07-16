#lang racket/base

(provide parse-gpx workout%)
(require 
  euclid/plane/angle racket/class racket/match racket/date (only-in racket/list last first) (only-in xml read-xml xml->xexpr document-element))

(define (extract-date str) ;; yyyy-mm-ddThh:mm:ssZ
  (let ((second (string->number (substring str 17 19)))
        (minute (string->number (substring str 14 16)))
        (hour (string->number (substring str 11 13)))
        (day (string->number (substring str 8 10)))
        (month (string->number (substring str 5 7)))
        (year (string->number (substring str 0 4))))
         
    (make-date second minute hour day month year 0 0 #f 0)))

(define (time-diff-s date1 date2) ;; assumption say month - year 
  (+ (* (- (date-day date2) (date-day date1)) 24 60 60)
     (* (- (date-hour date2) (date-hour date1)) 60 60)
     (* (- (date-minute date2) (date-minute date1)) 60)
     (- (date-second date2) (date-second date1))))

(define (parse-gpx file-path)

  (define (deep-filter lst fltr?)
    (cond ((null? lst) lst)
          ((pair? (car lst))
           (cons (deep-filter (car lst) fltr?)
                 (deep-filter (cdr lst) fltr?)))
          ((fltr? (car lst)) (cons (car lst)
                                   (deep-filter (cdr lst) fltr?)))
          (else (deep-filter (cdr lst) fltr?))))

  (define (extract-track-info lst)
    (let ((min-elevation +inf.0)
          (max-elevation -inf.0))

      (define (extract-time point)
        (match point
          [`(trkpt
             ((lat ,lat) (lon ,lon))
             (ele () ,ele)
             (time () ,time))
           (extract-date time)]
          [`(trkpt
             ((lat ,lat) (lon ,lon))
             (ele () ,ele)
             (time () ,time)
             (extensions () (gpxtpx:TrackPointExtension () (gpxtpx:cad () ,cad))))
           (extract-date time)]
          [else (error "ill-formed trkpt" point)]))

      (define (extract point)
        (match point
          [`(trkpt
             ((lat ,lat) (lon ,lon))
             (ele () ,ele)
             (time () ,time))
           (let ((ele (string->number ele)))
             (cond ((> ele max-elevation) (set! max-elevation ele))
                   ((< ele min-elevation) (set! min-elevation ele)))
             (vector (string->number lat) (string->number lon)))]
          [`(trkpt
             ((lat ,lat) (lon ,lon))
             (ele () ,ele)
             (time () ,time)
             (extensions () (gpxtpx:TrackPointExtension () (gpxtpx:cad () ,cad))))
           (let ((ele (string->number ele)))
             (cond ((> ele max-elevation) (set! max-elevation ele))
                   ((< ele min-elevation) (set! min-elevation ele)))
             (vector (string->number lat) (string->number lon)))]
          [else (error "ill-formed trkpt" point)]))

                 

      (values (foldr (lambda (pt acc)
                       (cons (extract pt) acc))
                     '()
                     lst)
              min-elevation
              max-elevation
              (extract-time (last lst)))))
        
          
  
  (let* ((dirty-tree (xml->xexpr (document-element (read-xml (open-input-file file-path)))))
         (tree (deep-filter dirty-tree (lambda (x) (not (and (string? x) (regexp-match #rx"\n *" x))))))
         (meta-data (caddr tree))
         (trk (cadddr tree))
         (segment (cddddr trk)))

    (define-values (route min-elevation max-elevation end) (extract-track-info (cddar segment)))
    (new workout%
         [start-date (extract-date (caddr (caddr meta-data)))]
         [end-date end]
         [route route]
         [max-elevation max-elevation]
         [min-elevation min-elevation])))

                  
(define (route->distance route)
  (define (remove-last lst)
    (if (or (null? lst) (null? (cdr lst)))
        '()
        (cons (car lst) (remove-last (cdr lst)))))
          
  ;; implemented the algo described here: https://stackoverflow.com/a/19632918
  (define (distance c1 c2) 
    (define (lat c)
      (vector-ref c 0))
    (define (lon c)
      (vector-ref c 1))
    (let ((deltaLat (angle-radians (degrees (- (lat c2) (lat c1)))))
          (deltaLon (angle-radians (degrees (- (lon c2) (lon c1))))))
      (let* ((a (+ (expt (sin (/ deltaLat 2)) 2) (* (cos (angle-radians (degrees (lat c1)))) (cos (angle-radians (degrees (lat c2)))) (expt (sin (/ deltaLon 2)) 2))))
             (great-circle-distance (* 2 (atan (sqrt a) (sqrt (- 1 a))))))
        (* great-circle-distance 6371)))) ;; in km 
    
  (foldl (lambda (c1 c2 acc)
           (+ acc (distance c1 c2)))
         0
         (remove-last route)
         (cdr route)))
               

(define workout% (class object%
                   (super-new)
                   (init-field start-date end-date route max-elevation min-elevation)
                   (field [injuries '()]
                          [perceived-intensity 0]
                          [duration (time-diff-s start-date end-date)]
                          [elevation-difference (-  max-elevation  min-elevation)]
                          [distance (route->distance route)])
                   (external-neural-field training-intensity)
                   

                   (define/public (assoc-injury! injury)
                     (set! injuries (cons injury injuries)))))















  
