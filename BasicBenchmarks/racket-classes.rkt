#lang racket/base
(require racket/class "racket-ML-models.rkt")
(provide intra-object-1-out
         intra-object-1-in
         #|
         inter-object-1  
         inter-object-2  
         inter-object-3  
         inter-object-4  
         inter-object-5  
         inter-object-6  
         inter-object-7  
         inter-object-8  
         inter-object-9  
         inter-object-10  
         inter-object-11  
         inter-object-12  
         inter-object-13  
         inter-object-14  
         inter-object-15  
         inter-object-16  
         inter-object-17  
         inter-object-18  
         inter-object-19  
         inter-object-20 |#
         inter-object-class%)

(require pyffi)
(initialize)
(post-initialize)


(define intra-object-1-out% (class object%
                              (field [a 1] [b 2] [c 3])
                              (field [neural1 (infer-neural1)]
                                     [neural3 (infer-neural3)]
                                     ;; complete pattern: 
                                     [neural5 (infer-neural5)]
                                     [neural7 (infer-neural7)]
                                     [neural9 (infer-neural9)]
                                     [neural11 (infer-neural11)]
                                     [neural13 (infer-neural13)]
                                     [neural15 (infer-neural15)]
                                     [neural17 (infer-neural17)]
                                     [neural19 (infer-neural19)])

                         
                              (define/public (infer-neural1)
                                (infer-1-in-1-out a))
                              (define/public (train-neural1)
                                (train-1-in-1-out a neural1))
                          
                              (define/public (infer-neural3)
                                (infer-3-in-1-out a b c))
                              (define/public (train-neural3)
                                (train-3-in-1-out a b c neural3))

                              (define/public (infer-neural5)
                                (infer-5-in-1-out a b c a b))
                              (define/public (train-neural5)
                                (train-5-in-1-out a b c a b neural5))

                              (define/public (infer-neural7)
                                (infer-7-in-1-out a b c a b c a))
                              (define/public (train-neural7)
                                (train-7-in-1-out a b c a b c a neural7))

                              (define/public (infer-neural9)
                                (infer-9-in-1-out a b c a b c a b c))
                              (define/public (train-neural9)
                                (train-9-in-1-out a b c a b c a b c neural9))

                              (define/public (infer-neural11)
                                (infer-11-in-1-out a b c a b c a b c a b))
                              (define/public (train-neural11)
                                (train-11-in-1-out a b c a b c a b c a b neural11))

                              (define/public (infer-neural13)
                                (infer-13-in-1-out a b c a b c a b c a b c a))
                              (define/public (train-neural13)
                                (train-13-in-1-out a b c a b c a b c a b c a neural13))

                              (define/public (infer-neural15)
                                (infer-15-in-1-out a b c a b c a b c a b c a b c))
                              (define/public (train-neural15)
                                (train-15-in-1-out a b c a b c a b c a b c a b c neural15))

                              (define/public (infer-neural17)
                                (infer-17-in-1-out a b c a b c a b c a b c a b c a b))
                              (define/public (train-neural17)
                                (train-17-in-1-out a b c a b c a b c a b c a b c a b neural17))

                              (define/public (infer-neural19)
                                (infer-19-in-1-out a b c a b c a b c a b c a b c a b c a))
                              (define/public (train-neural19)
                                (train-19-in-1-out a b c a b c a b c a b c a b c a b c a neural19))
 
                              (super-new)))


(define intra-object-1-in% (class object%
                             (field [in 1])
                             (field [neural3.1 #f]
                                    [neural3.2 #f]
                                    [neural3.3 #f]
                                
                                    [neural5.1 #f]
                                    [neural5.2 #f]
                                    [neural5.3 #f]
                                    [neural5.4 #f]
                                    [neural5.5 #f]

                                    [neural7.1 #f]
                                    [neural7.2 #f]
                                    [neural7.3 #f]
                                    [neural7.4 #f]
                                    [neural7.5 #f]
                                    [neural7.6 #f]
                                    [neural7.7 #f]

                                    [neural9.1 #f]
                                    [neural9.2 #f]
                                    [neural9.3 #f]
                                    [neural9.4 #f]
                                    [neural9.5 #f]
                                    [neural9.6 #f]
                                    [neural9.7 #f]
                                    [neural9.8 #f]
                                    [neural9.9 #f]

                                    [neural11.1 #f]
                                    [neural11.2 #f]
                                    [neural11.3 #f]
                                    [neural11.4 #f]
                                    [neural11.5 #f]
                                    [neural11.6 #f]
                                    [neural11.7 #f]
                                    [neural11.8 #f]
                                    [neural11.9 #f]
                                    [neural11.10 #f]
                                    [neural11.11 #f]

                                    [neural13.1 #f]
                                    [neural13.2 #f]
                                    [neural13.3 #f]
                                    [neural13.4 #f]
                                    [neural13.5 #f]
                                    [neural13.6 #f]
                                    [neural13.7 #f]
                                    [neural13.8 #f]
                                    [neural13.9 #f]
                                    [neural13.10 #f]
                                    [neural13.11 #f]
                                    [neural13.12 #f]
                                    [neural13.13 #f]

                                    [neural15.1 #f]
                                    [neural15.2 #f]
                                    [neural15.3 #f]
                                    [neural15.4 #f]
                                    [neural15.5 #f]
                                    [neural15.6 #f]
                                    [neural15.7 #f]
                                    [neural15.8 #f]
                                    [neural15.9 #f]
                                    [neural15.10 #f]
                                    [neural15.11 #f]
                                    [neural15.12 #f]
                                    [neural15.13 #f]
                                    [neural15.14 #f]
                                    [neural15.15 #f]

                                    [neural17.1 #f]
                                    [neural17.2 #f]
                                    [neural17.3 #f]
                                    [neural17.4 #f]
                                    [neural17.5 #f]
                                    [neural17.6 #f]
                                    [neural17.7 #f]
                                    [neural17.8 #f]
                                    [neural17.9 #f]
                                    [neural17.10 #f]
                                    [neural17.11 #f]
                                    [neural17.12 #f]
                                    [neural17.13 #f]
                                    [neural17.14 #f]
                                    [neural17.15 #f]
                                    [neural17.16 #f]
                                    [neural17.17 #f]

                                    [neural19.1 #f]
                                    [neural19.2 #f]
                                    [neural19.3 #f]
                                    [neural19.4 #f]
                                    [neural19.5 #f]
                                    [neural19.6 #f]
                                    [neural19.7 #f]
                                    [neural19.8 #f]
                                    [neural19.9 #f]
                                    [neural19.10 #f]
                                    [neural19.11 #f]
                                    [neural19.12 #f]
                                    [neural19.13 #f]
                                    [neural19.14 #f]
                                    [neural19.15 #f]
                                    [neural19.16 #f]
                                    [neural19.17 #f]
                                    [neural19.18 #f]
                                    [neural19.19 #f])

                             (define/public (infer-neurals3!)
                               (let ((res (pylist->list (infer-1-in-3-out in))))
                                 (set! neural3.1 (car res))
                                 (set! neural3.2 (cadr res))
                                 (set! neural3.3 (caddr res))))
                             (define/public (train-neurals3)
                               (train-1-in-3-out in neural3.1 neural3.2 neural3.3))
                         
                             (define/public (infer-neurals5!)
                               (let ((res (pylist->list (infer-1-in-5-out in))))
                                 (set! neural5.1 (car res))
                                 (set! neural5.2 (cadr res))
                                 (set! neural5.3 (caddr res))
                                 (set! neural5.4 (cadddr res))
                                 (set! neural5.5 (list-ref res 4))))
                             (define/public (train-neurals5)
                               (train-1-in-5-out in neural5.1 neural5.2 neural5.3 neural5.4 neural5.5))

                             (define/public (infer-neurals7!)
                               (let ((res (pylist->list (infer-1-in-7-out in))))
                                 (set! neural7.1 (list-ref res 0))
                                 (set! neural7.2 (list-ref res 1))
                                 (set! neural7.3 (list-ref res 2))
                                 (set! neural7.4 (list-ref res 3))
                                 (set! neural7.5 (list-ref res 4))
                                 (set! neural7.6 (list-ref res 5))
                                 (set! neural7.7 (list-ref res 6))))

                             (define/public (train-neurals7)
                               (train-1-in-7-out in neural7.1 neural7.2 neural7.3 neural7.4 neural7.5 neural7.6 neural7.7))

                             (define/public (infer-neurals9!)
                               (let ((res (pylist->list (infer-1-in-9-out in))))
                                 (set! neural9.1 (list-ref res 0))
                                 (set! neural9.2 (list-ref res 1))
                                 (set! neural9.3 (list-ref res 2))
                                 (set! neural9.4 (list-ref res 3))
                                 (set! neural9.5 (list-ref res 4))
                                 (set! neural9.6 (list-ref res 5))
                                 (set! neural9.7 (list-ref res 6))
                                 (set! neural9.8 (list-ref res 7))
                                 (set! neural9.9 (list-ref res 8))))

                             (define/public (train-neurals9)
                               (train-1-in-9-out in neural9.1 neural9.2 neural9.3 neural9.4 neural9.5 neural9.6 neural9.7 neural9.8 neural9.9))

                             (define/public (infer-neurals11!)
                               (let ((res (pylist->list (infer-1-in-11-out in))))
                                 (set! neural11.1  (list-ref res 0))
                                 (set! neural11.2  (list-ref res 1))
                                 (set! neural11.3  (list-ref res 2))
                                 (set! neural11.4  (list-ref res 3))
                                 (set! neural11.5  (list-ref res 4))
                                 (set! neural11.6  (list-ref res 5))
                                 (set! neural11.7  (list-ref res 6))
                                 (set! neural11.8  (list-ref res 7))
                                 (set! neural11.9  (list-ref res 8))
                                 (set! neural11.10 (list-ref res 9))
                                 (set! neural11.11 (list-ref res 10))))

                             (define/public (train-neurals11)
                               (train-1-in-11-out in neural11.1 neural11.2 neural11.3 neural11.4 neural11.5 neural11.6 neural11.7 neural11.8 neural11.9 neural11.10 neural11.11))

                             (define/public (infer-neurals13!)
                               (let ((res (pylist->list (infer-1-in-13-out in))))
                                 (set! neural13.1  (list-ref res 0))
                                 (set! neural13.2  (list-ref res 1))
                                 (set! neural13.3  (list-ref res 2))
                                 (set! neural13.4  (list-ref res 3))
                                 (set! neural13.5  (list-ref res 4))
                                 (set! neural13.6  (list-ref res 5))
                                 (set! neural13.7  (list-ref res 6))
                                 (set! neural13.8  (list-ref res 7))
                                 (set! neural13.9  (list-ref res 8))
                                 (set! neural13.10 (list-ref res 9))
                                 (set! neural13.11 (list-ref res 10))
                                 (set! neural13.12 (list-ref res 11))
                                 (set! neural13.13 (list-ref res 12))))

                             (define/public (train-neurals13)
                               (train-1-in-13-out in neural13.1 neural13.2 neural13.3 neural13.4 neural13.5 neural13.6 neural13.7 neural13.8 neural13.9 neural13.10 neural13.11 neural13.12 neural13.13))

                             (define/public (infer-neurals15!)
                               (let ((res (pylist->list (infer-1-in-15-out in))))
                                 (set! neural15.1  (list-ref res 0))
                                 (set! neural15.2  (list-ref res 1))
                                 (set! neural15.3  (list-ref res 2))
                                 (set! neural15.4  (list-ref res 3))
                                 (set! neural15.5  (list-ref res 4))
                                 (set! neural15.6  (list-ref res 5))
                                 (set! neural15.7  (list-ref res 6))
                                 (set! neural15.8  (list-ref res 7))
                                 (set! neural15.9  (list-ref res 8))
                                 (set! neural15.10 (list-ref res 9))
                                 (set! neural15.11 (list-ref res 10))
                                 (set! neural15.12 (list-ref res 11))
                                 (set! neural15.13 (list-ref res 12))
                                 (set! neural15.14 (list-ref res 13))
                                 (set! neural15.15 (list-ref res 14))))

                             (define/public (train-neurals15)
                               (train-1-in-15-out in neural15.1 neural15.2 neural15.3 neural15.4 neural15.5 neural15.6 neural15.7 neural15.8 neural15.9 neural15.10 neural15.11 neural15.12 neural15.13 neural15.14 neural15.15))

                             (define/public (infer-neurals17!)
                               (let ((res (pylist->list (infer-1-in-17-out in))))
                                 (set! neural17.1  (list-ref res 0))
                                 (set! neural17.2  (list-ref res 1))
                                 (set! neural17.3  (list-ref res 2))
                                 (set! neural17.4  (list-ref res 3))
                                 (set! neural17.5  (list-ref res 4))
                                 (set! neural17.6  (list-ref res 5))
                                 (set! neural17.7  (list-ref res 6))
                                 (set! neural17.8  (list-ref res 7))
                                 (set! neural17.9  (list-ref res 8))
                                 (set! neural17.10 (list-ref res 9))
                                 (set! neural17.11 (list-ref res 10))
                                 (set! neural17.12 (list-ref res 11))
                                 (set! neural17.13 (list-ref res 12))
                                 (set! neural17.14 (list-ref res 13))
                                 (set! neural17.15 (list-ref res 14))
                                 (set! neural17.16 (list-ref res 15))
                                 (set! neural17.17 (list-ref res 16))))

                             (define/public (train-neurals17)
                               (train-1-in-17-out in neural17.1 neural17.2 neural17.3 neural17.4 neural17.5 neural17.6 neural17.7 neural17.8 neural17.9 neural17.10 neural17.11 neural17.12 neural17.13 neural17.14 neural17.15 neural17.16 neural17.17))

                             (define/public (infer-neurals19!)
                               (let ((res (pylist->list (infer-1-in-19-out in))))
                                 (set! neural19.1  (list-ref res 0))
                                 (set! neural19.2  (list-ref res 1))
                                 (set! neural19.3  (list-ref res 2))
                                 (set! neural19.4  (list-ref res 3))
                                 (set! neural19.5  (list-ref res 4))
                                 (set! neural19.6  (list-ref res 5))
                                 (set! neural19.7  (list-ref res 6))
                                 (set! neural19.8  (list-ref res 7))
                                 (set! neural19.9  (list-ref res 8))
                                 (set! neural19.10 (list-ref res 9))
                                 (set! neural19.11 (list-ref res 10))
                                 (set! neural19.12 (list-ref res 11))
                                 (set! neural19.13 (list-ref res 12))
                                 (set! neural19.14 (list-ref res 13))
                                 (set! neural19.15 (list-ref res 14))
                                 (set! neural19.16 (list-ref res 15))
                                 (set! neural19.17 (list-ref res 16))
                                 (set! neural19.18 (list-ref res 17))
                                 (set! neural19.19 (list-ref res 18))))

                             (define/public (train-neurals19)
                               (train-1-in-19-out in neural19.1 neural19.2 neural19.3 neural19.4 neural19.5 neural19.6 neural19.7 neural19.8 neural19.9 neural19.10 neural19.11 neural19.12 neural19.13 neural19.14 neural19.15 neural19.16 neural19.17 neural19.18 neural19.19))
  

                             (infer-neurals3!)
                             (infer-neurals5!)
                             (infer-neurals7!)
                             (infer-neurals9!)
                             (infer-neurals11!)
                             (infer-neurals13!)
                             (infer-neurals15!)
                             (infer-neurals17!)
                             (infer-neurals19!)
                             
                             (super-new)))


(define inter-object-class% (class object%
                              (super-new)
                              (field [external-neural #f] [a 1])

                              ;; 1 in 1 out
                              (define/public (infer-neural-1-in-1-out in-obj-1)
                                (infer-1-in-1-out (get-field a in-obj-1)))
                              (define/public (train-neural-1-in-1-out in-obj-1)
                                (train-1-in-1-out (get-field a in-obj-1) external-neural))

                              ;; x in 1 out
                              (define/public (infer-neural-3-in-1-out in-obj-1 in-obj-2 in-obj-3)
                                (infer-3-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3)))
                              (define/public (train-neural-3-in-1-out in-obj-1 in-obj-2 in-obj-3)
                                (train-3-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) external-neural))

                              (define/public (infer-neural-5-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5)
                                (infer-5-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4) (get-field a in-obj-5)))
                              (define/public (train-neural-5-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5)
                                (train-5-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4) (get-field a in-obj-5) external-neural))

                              (define/public (infer-neural-7-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7)
                                (infer-7-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3)
                                                  (get-field a in-obj-4) (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7)))

                              (define/public (train-neural-7-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7)
                                (train-7-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                  (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) external-neural))

                              (define/public (infer-neural-9-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7 in-obj-8 in-obj-9)
                                (infer-9-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                  (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) (get-field a in-obj-8)
                                                  (get-field a in-obj-9)))

                              (define/public (train-neural-9-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7 in-obj-8 in-obj-9)
                                (train-9-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                  (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) (get-field a in-obj-8)
                                                  (get-field a in-obj-9)external-neural))

                              (define/public (infer-neural-11-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7 in-obj-8 in-obj-9 in-obj-10 in-obj-11)
                                (infer-11-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                   (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) (get-field a in-obj-8)
                                                   (get-field a in-obj-9) (get-field a in-obj-10) (get-field a in-obj-11)))

                              (define/public (train-neural-11-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7 in-obj-8 in-obj-9 in-obj-10 in-obj-11)
                                (train-11-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                   (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) (get-field a in-obj-8)
                                                   (get-field a in-obj-9) (get-field a in-obj-10) (get-field a in-obj-11) external-neural))


                              (define/public (infer-neural-13-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7 in-obj-8 in-obj-9 in-obj-10 in-obj-11 in-obj-12 in-obj-13)
                                (infer-13-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                   (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) (get-field a in-obj-8)
                                                   (get-field a in-obj-9) (get-field a in-obj-10) (get-field a in-obj-11) (get-field a in-obj-12)
                                                   (get-field a in-obj-13)))

                              (define/public (train-neural-13-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7 in-obj-8 in-obj-9 in-obj-10 in-obj-11 in-obj-12 in-obj-13)
                                (train-13-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                   (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) (get-field a in-obj-8)
                                                   (get-field a in-obj-9) (get-field a in-obj-10) (get-field a in-obj-11) (get-field a in-obj-12)
                                                   (get-field a in-obj-13) external-neural))

                              (define/public (infer-neural-15-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7 in-obj-8 in-obj-9 in-obj-10 in-obj-11 in-obj-12 in-obj-13 in-obj-14 in-obj-15)
                                (infer-15-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                   (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) (get-field a in-obj-8)
                                                   (get-field a in-obj-9) (get-field a in-obj-10) (get-field a in-obj-11) (get-field a in-obj-12)
                                                   (get-field a in-obj-13) (get-field a in-obj-14) (get-field a in-obj-15)))

                              (define/public (train-neural-15-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7 in-obj-8 in-obj-9 in-obj-10 in-obj-11 in-obj-12 in-obj-13 in-obj-14 in-obj-15)
                                (train-15-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                   (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) (get-field a in-obj-8)
                                                   (get-field a in-obj-9) (get-field a in-obj-10) (get-field a in-obj-11) (get-field a in-obj-12)
                                                   (get-field a in-obj-13) (get-field a in-obj-14) (get-field a in-obj-15) external-neural))

                              (define/public (infer-neural-17-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7 in-obj-8 in-obj-9 in-obj-10 in-obj-11 in-obj-12 in-obj-13 in-obj-14 in-obj-15 in-obj-16 in-obj-17)
                                (infer-17-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                   (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) (get-field a in-obj-8)
                                                   (get-field a in-obj-9) (get-field a in-obj-10) (get-field a in-obj-11) (get-field a in-obj-12)
                                                   (get-field a in-obj-13) (get-field a in-obj-14) (get-field a in-obj-15) (get-field a in-obj-16)
                                                   (get-field a in-obj-17)))

                              (define/public (train-neural-17-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7 in-obj-8 in-obj-9 in-obj-10 in-obj-11 in-obj-12 in-obj-13 in-obj-14 in-obj-15 in-obj-16 in-obj-17)
                                (train-17-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                   (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) (get-field a in-obj-8)
                                                   (get-field a in-obj-9) (get-field a in-obj-10) (get-field a in-obj-11) (get-field a in-obj-12)
                                                   (get-field a in-obj-13) (get-field a in-obj-14) (get-field a in-obj-15) (get-field a in-obj-16)
                                                   (get-field a in-obj-17) external-neural))

                              (define/public (infer-neural-19-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7 in-obj-8 in-obj-9 in-obj-10 in-obj-11 in-obj-12 in-obj-13 in-obj-14 in-obj-15 in-obj-16 in-obj-17 in-obj-18 in-obj-19)
                                (infer-19-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                   (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) (get-field a in-obj-8)
                                                   (get-field a in-obj-9) (get-field a in-obj-10) (get-field a in-obj-11) (get-field a in-obj-12)
                                                   (get-field a in-obj-13) (get-field a in-obj-14) (get-field a in-obj-15) (get-field a in-obj-16)
                                                   (get-field a in-obj-17) (get-field a in-obj-18) (get-field a in-obj-19)))

                              (define/public (train-neural-19-in-1-out in-obj-1 in-obj-2 in-obj-3 in-obj-4 in-obj-5 in-obj-6 in-obj-7 in-obj-8 in-obj-9 in-obj-10 in-obj-11 in-obj-12 in-obj-13 in-obj-14 in-obj-15 in-obj-16 in-obj-17 in-obj-18 in-obj-19)
                                (train-19-in-1-out (get-field a in-obj-1) (get-field a in-obj-2) (get-field a in-obj-3) (get-field a in-obj-4)
                                                   (get-field a in-obj-5) (get-field a in-obj-6) (get-field a in-obj-7) (get-field a in-obj-8)
                                                   (get-field a in-obj-9) (get-field a in-obj-10) (get-field a in-obj-11) (get-field a in-obj-12)
                                                   (get-field a in-obj-13) (get-field a in-obj-14) (get-field a in-obj-15) (get-field a in-obj-16)
                                                   (get-field a in-obj-17) (get-field a in-obj-18) (get-field a in-obj-19) external-neural))

                              
                              ;; 1 in y out
                              (define/public (infer-neural-1-in-3-out! in-obj out-obj-2 out-obj-3)
                                (let ((res (pylist->list (infer-1-in-3-out (get-field a in-obj)))))
                                  (set! external-neural (car res))
                                  (set-field! external-neural out-obj-2 (cadr res))
                                  (set-field! external-neural out-obj-3 (caddr res))))
                              (define/public (train-neural-1-in-3-out in-obj out-obj-2 out-obj-3)
                                (train-1-in-3-out (get-field a in-obj) external-neural (get-field external-neural out-obj-2) (get-field external-neural out-obj-3)))

                              (define/public (infer-neural-1-in-5-out! in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5)
                                (let ((res (pylist->list (infer-1-in-5-out (get-field a in-obj)))))
                                  (set! external-neural (car res))
                                  (set-field! external-neural out-obj-2 (cadr res))
                                  (set-field! external-neural out-obj-3 (caddr res))
                                  (set-field! external-neural out-obj-4 (cadddr res))
                                  (set-field! external-neural out-obj-5 (list-ref res 4))))
                              (define/public (train-neural-1-in-5-out in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5)
                                (train-1-in-5-out (get-field a in-obj) external-neural (get-field external-neural out-obj-2)(get-field external-neural out-obj-3) (get-field external-neural out-obj-4) (get-field external-neural out-obj-5)))

                              (define/public (infer-neural-1-in-7-out! in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7)
                                (let ((res (pylist->list (infer-1-in-7-out (get-field a in-obj)))))
                                  (set! external-neural (car res))
                                  (set-field! external-neural out-obj-2 (cadr res))
                                  (set-field! external-neural out-obj-3 (caddr res))
                                  (set-field! external-neural out-obj-4 (cadddr res))
                                  (set-field! external-neural out-obj-5 (list-ref res 4))
                                  (set-field! external-neural out-obj-6 (list-ref res 5))
                                  (set-field! external-neural out-obj-7 (list-ref res 6))))

                              (define/public (train-neural-1-in-7-out in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7)
                                (train-1-in-7-out (get-field a in-obj) external-neural (get-field external-neural out-obj-2)(get-field external-neural out-obj-3)
                                                  (get-field external-neural out-obj-4)(get-field external-neural out-obj-5)
                                                  (get-field external-neural out-obj-6)(get-field external-neural out-obj-7)))

                              (define/public (infer-neural-1-in-9-out! in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8 out-obj-9)
                                (let ((res (pylist->list (infer-1-in-9-out (get-field a in-obj)))))
                                  (set! external-neural (car res))
                                  (set-field! external-neural out-obj-2 (cadr res))
                                  (set-field! external-neural out-obj-3 (caddr res))
                                  (set-field! external-neural out-obj-4 (cadddr res))
                                  (set-field! external-neural out-obj-5 (list-ref res 4))
                                  (set-field! external-neural out-obj-6 (list-ref res 5))
                                  (set-field! external-neural out-obj-7 (list-ref res 6))
                                  (set-field! external-neural out-obj-8 (list-ref res 7))
                                  (set-field! external-neural out-obj-9 (list-ref res 8))))

                              (define/public (train-neural-1-in-9-out in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8 out-obj-9)
                                (train-1-in-9-out (get-field a in-obj) external-neural
                                                  (get-field external-neural out-obj-2) (get-field external-neural out-obj-3)
                                                  (get-field external-neural out-obj-4) (get-field external-neural out-obj-5)
                                                  (get-field external-neural out-obj-6) (get-field external-neural out-obj-7)
                                                  (get-field external-neural out-obj-8) (get-field external-neural out-obj-9)))

                              (define/public (infer-neural-1-in-11-out! in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8 out-obj-9 out-obj-10 out-obj-11)
                                (let ((res (pylist->list (infer-1-in-11-out (get-field a in-obj)))))
                                  (set! external-neural (car res))
                                  (set-field! external-neural out-obj-2 (cadr res))
                                  (set-field! external-neural out-obj-3 (caddr res))
                                  (set-field! external-neural out-obj-4 (cadddr res))
                                  (set-field! external-neural out-obj-5 (list-ref res 4))
                                  (set-field! external-neural out-obj-6 (list-ref res 5))
                                  (set-field! external-neural out-obj-7 (list-ref res 6))
                                  (set-field! external-neural out-obj-8 (list-ref res 7))
                                  (set-field! external-neural out-obj-9 (list-ref res 8))
                                  (set-field! external-neural out-obj-10 (list-ref res 9))
                                  (set-field! external-neural out-obj-11 (list-ref res 10))))

                              (define/public (train-neural-1-in-11-out in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8 out-obj-9 out-obj-10 out-obj-11)
                                (train-1-in-11-out (get-field a in-obj) external-neural
                                                   (get-field external-neural out-obj-2) (get-field external-neural out-obj-3)
                                                   (get-field external-neural out-obj-4) (get-field external-neural out-obj-5)
                                                   (get-field external-neural out-obj-6) (get-field external-neural out-obj-7)
                                                   (get-field external-neural out-obj-8) (get-field external-neural out-obj-9)
                                                   (get-field external-neural out-obj-10) (get-field external-neural out-obj-11)))

                              (define/public (infer-neural-1-in-13-out! in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8 out-obj-9 out-obj-10 out-obj-11 out-obj-12 out-obj-13)
                                (let ((res (pylist->list (infer-1-in-13-out (get-field a in-obj)))))
                                  (set! external-neural (car res))
                                  (set-field! external-neural out-obj-2 (cadr res))
                                  (set-field! external-neural out-obj-3 (caddr res))
                                  (set-field! external-neural out-obj-4 (cadddr res))
                                  (set-field! external-neural out-obj-5 (list-ref res 4))
                                  (set-field! external-neural out-obj-6 (list-ref res 5))
                                  (set-field! external-neural out-obj-7 (list-ref res 6))
                                  (set-field! external-neural out-obj-8 (list-ref res 7))
                                  (set-field! external-neural out-obj-9 (list-ref res 8))
                                  (set-field! external-neural out-obj-10 (list-ref res 9))
                                  (set-field! external-neural out-obj-11 (list-ref res 10))
                                  (set-field! external-neural out-obj-12 (list-ref res 11))
                                  (set-field! external-neural out-obj-13 (list-ref res 12))))

                              (define/public (train-neural-1-in-13-out in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8 out-obj-9 out-obj-10 out-obj-11 out-obj-12 out-obj-13)
                                (train-1-in-13-out (get-field a in-obj) external-neural
                                                   (get-field external-neural out-obj-2) (get-field external-neural out-obj-3)
                                                   (get-field external-neural out-obj-4) (get-field external-neural out-obj-5)
                                                   (get-field external-neural out-obj-6) (get-field external-neural out-obj-7)
                                                   (get-field external-neural out-obj-8) (get-field external-neural out-obj-9)
                                                   (get-field external-neural out-obj-10) (get-field external-neural out-obj-11)
                                                   (get-field external-neural out-obj-12) (get-field external-neural out-obj-13)))

                              (define/public (infer-neural-1-in-15-out! in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8 out-obj-9 out-obj-10 out-obj-11 out-obj-12 out-obj-13 out-obj-14 out-obj-15)
                                (let ((res (pylist->list (infer-1-in-15-out (get-field a in-obj)))))
                                  (set! external-neural (car res))
                                  (set-field! external-neural out-obj-2 (cadr res))
                                  (set-field! external-neural out-obj-3 (caddr res))
                                  (set-field! external-neural out-obj-4 (cadddr res))
                                  (set-field! external-neural out-obj-5 (list-ref res 4))
                                  (set-field! external-neural out-obj-6 (list-ref res 5))
                                  (set-field! external-neural out-obj-7 (list-ref res 6))
                                  (set-field! external-neural out-obj-8 (list-ref res 7))
                                  (set-field! external-neural out-obj-9 (list-ref res 8))
                                  (set-field! external-neural out-obj-10 (list-ref res 9))
                                  (set-field! external-neural out-obj-11 (list-ref res 10))
                                  (set-field! external-neural out-obj-12 (list-ref res 11))
                                  (set-field! external-neural out-obj-13 (list-ref res 12))
                                  (set-field! external-neural out-obj-14 (list-ref res 13))
                                  (set-field! external-neural out-obj-15 (list-ref res 14))))

                              (define/public (train-neural-1-in-15-out in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8 out-obj-9 out-obj-10 out-obj-11 out-obj-12 out-obj-13 out-obj-14 out-obj-15)
                                (train-1-in-15-out (get-field a in-obj) external-neural
                                                   (get-field external-neural out-obj-2) (get-field external-neural out-obj-3)
                                                   (get-field external-neural out-obj-4) (get-field external-neural out-obj-5)
                                                   (get-field external-neural out-obj-6) (get-field external-neural out-obj-7)
                                                   (get-field external-neural out-obj-8) (get-field external-neural out-obj-9)
                                                   (get-field external-neural out-obj-10) (get-field external-neural out-obj-11)
                                                   (get-field external-neural out-obj-12) (get-field external-neural out-obj-13)
                                                   (get-field external-neural out-obj-14) (get-field external-neural out-obj-15)))

                              (define/public (infer-neural-1-in-17-out! in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8 out-obj-9 out-obj-10 out-obj-11 out-obj-12 out-obj-13 out-obj-14 out-obj-15 out-obj-16 out-obj-17)
                                (let ((res (pylist->list (infer-1-in-17-out (get-field a in-obj)))))
                                  (set! external-neural (car res))
                                  (for-each (lambda (obj res)
                                              (set-field! external-neural obj res))
                                            (list out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6
                                                  out-obj-7 out-obj-8 out-obj-9 out-obj-10 out-obj-11
                                                  out-obj-12 out-obj-13 out-obj-14 out-obj-15 out-obj-16
                                                  out-obj-17)
                                            (cdr res))))

                              (define/public (train-neural-1-in-17-out in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8 out-obj-9 out-obj-10 out-obj-11 out-obj-12 out-obj-13 out-obj-14 out-obj-15 out-obj-16 out-obj-17)
                                (apply train-1-in-17-out (cons (get-field a in-obj)
                                                               (cons external-neural
                                                                     (map (lambda (obj) (get-field external-neural obj))
                                                                          (list out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8
                                                                                out-obj-9 out-obj-10 out-obj-11 out-obj-12 out-obj-13 out-obj-14 out-obj-15
                                                                                out-obj-16 out-obj-17))))))

                              (define/public (infer-neural-1-in-19-out! in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8 out-obj-9 out-obj-10 out-obj-11 out-obj-12 out-obj-13 out-obj-14 out-obj-15 out-obj-16 out-obj-17 out-obj-18 out-obj-19)
                                (let ((res (pylist->list (infer-1-in-19-out (get-field a in-obj)))))
                                  (set! external-neural (car res))
                                  (for-each (lambda (obj res)
                                              (set-field! external-neural obj res))
                                            (list out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6
                                                  out-obj-7 out-obj-8 out-obj-9 out-obj-10 out-obj-11
                                                  out-obj-12 out-obj-13 out-obj-14 out-obj-15 out-obj-16
                                                  out-obj-17 out-obj-18 out-obj-19)
                                            (cdr res))))

                              (define/public (train-neural-1-in-19-out in-obj out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8 out-obj-9 out-obj-10 out-obj-11 out-obj-12 out-obj-13 out-obj-14 out-obj-15 out-obj-16 out-obj-17 out-obj-18 out-obj-19)
                                (apply train-1-in-19-out (cons (get-field a in-obj)
                                                               (cons external-neural
                                                                     (map (lambda (obj) (get-field external-neural obj))
                                                                          (list out-obj-2 out-obj-3 out-obj-4 out-obj-5 out-obj-6 out-obj-7 out-obj-8
                                                                                out-obj-9 out-obj-10 out-obj-11 out-obj-12 out-obj-13 out-obj-14 out-obj-15
                                                                                out-obj-16 out-obj-17 out-obj-18 out-obj-19))))))))

(define intra-object-1-out (new intra-object-1-out%))
(define intra-object-1-in (new intra-object-1-in%))
#|
(define inter-object-1 (new inter-object-class%))
(define inter-object-2 (new inter-object-class%))
(define inter-object-3 (new inter-object-class%))
(define inter-object-4 (new inter-object-class%))
(define inter-object-5 (new inter-object-class%))
(define inter-object-6 (new inter-object-class%))
(define inter-object-7 (new inter-object-class%))
(define inter-object-8 (new inter-object-class%))
(define inter-object-9 (new inter-object-class%))
(define inter-object-10 (new inter-object-class%))
(define inter-object-11 (new inter-object-class%))
(define inter-object-12 (new inter-object-class%))
(define inter-object-13 (new inter-object-class%))
(define inter-object-14 (new inter-object-class%))
(define inter-object-15 (new inter-object-class%))
(define inter-object-16 (new inter-object-class%))
(define inter-object-17 (new inter-object-class%))
(define inter-object-18 (new inter-object-class%))
(define inter-object-19 (new inter-object-class%))
(define inter-object-20 (new inter-object-class%))
|#