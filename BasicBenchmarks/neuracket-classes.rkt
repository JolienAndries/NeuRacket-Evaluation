#lang racket
(provide intra-object-1-out intra-object-1-in inter-object-class%
         #|        inter-object-1  
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
         inter-object-20|#)
(require "neuracket-ML-models.rkt")

(define intra-object-1-out% (class object%
                              (field [a 1] [b 2] [c 3])
                              (label-field [lbl1 5] [lbl3 5] [lbl5 5] [lbl7 5]
                                           [lbl9 5] [lbl11 5] [lbl13 5] [lbl15 5]
                                           [lbl17 5] [lbl19 5])
                              (neural-field [(neural1) model-1-in-1-out (a) (lbl1)]
                                            [(neural3) model-3-in-1-out (a b c) (lbl3)]
                                            [(neural5) model-5-in-1-out (a b c a b) (lbl5)]
                                            [(neural7) model-7-in-1-out (a b c a b c a) (lbl7)]
                                            [(neural9) model-9-in-1-out (a b c a b c a b c) (lbl9)]
                                            [(neural11) model-11-in-1-out (a b c a b c a b c a b) (lbl11)]
                                            [(neural13) model-13-in-1-out (a b c a b c a b c a b c a) (lbl13)]
                                            [(neural15) model-15-in-1-out (a b c a b c a b c a b c a b c) (lbl15)]
                                            [(neural17) model-17-in-1-out (a b c a b c a b c a b c a b c a b) (lbl17)]
                                            [(neural19) model-19-in-1-out (a b c a b c a b c a b c a b c a b c a) (lbl19)])
                              (super-new)))

(define intra-object-1-in% (class object%
                             (field [in 1])
                             (label-field [lbl3.1 5] [lbl3.2 5] [lbl3.3 5]
                                          [lbl5.1 5] [lbl5.2 5] [lbl5.3 5] [lbl5.4 5] [lbl5.5 5]
                                          [lbl7.1 5] [lbl7.2 5] [lbl7.3 5] [lbl7.4 5] [lbl7.5 5] [lbl7.6 5] [lbl7.7 5]
                                          [lbl9.1 5] [lbl9.2 5] [lbl9.3 5] [lbl9.4 5] [lbl9.5 5] [lbl9.6 5] [lbl9.7 5] [lbl9.8 5] [lbl9.9 5]
                                          [lbl11.1 5] [lbl11.2 5] [lbl11.3 5] [lbl11.4 5] [lbl11.5 5] [lbl11.6 5] [lbl11.7 5] [lbl11.8 5] [lbl11.9 5] [lbl11.10 5] [lbl11.11 5]
                                          [lbl13.1 5] [lbl13.2 5] [lbl13.3 5] [lbl13.4 5] [lbl13.5 5] [lbl13.6 5] [lbl13.7 5] [lbl13.8 5] [lbl13.9 5] [lbl13.10 5] [lbl13.11 5] [lbl13.12 5] [lbl13.13 5] 
                                          [lbl15.1 5] [lbl15.2 5] [lbl15.3 5] [lbl15.4 5] [lbl15.5 5] [lbl15.6 5] [lbl15.7 5] [lbl15.8 5] [lbl15.9 5] [lbl15.10 5] [lbl15.11 5] [lbl15.12 5] [lbl15.13 5] [lbl15.14 5] [lbl15.15 5]
                                          [lbl17.1 5] [lbl17.2 5] [lbl17.3 5] [lbl17.4 5] [lbl17.5 5] [lbl17.6 5] [lbl17.7 5] [lbl17.8 5] [lbl17.9 5] [lbl17.10 5] [lbl17.11 5] [lbl17.12 5] [lbl17.13 5] [lbl17.14 5] [lbl17.15 5] [lbl17.16 5] [lbl17.17 5]
                                          [lbl19.1 5] [lbl19.2 5] [lbl19.3 5] [lbl19.4 5] [lbl19.5 5] [lbl19.6 5] [lbl19.7 5] [lbl19.8 5] [lbl19.9 5] [lbl19.10 5] [lbl19.11 5] [lbl19.12 5] [lbl19.13 5] [lbl19.14 5] [lbl19.15 5] [lbl19.16 5] [lbl19.17 5] [lbl19.18 5] [lbl19.19 5])
                             (neural-field [(neural3.1 neural3.2 neural3.3) model-1-in-3-out (in) (lbl3.1 lbl3.2 lbl3.3)]
                                           [(neural5.1 neural5.2 neural5.3 neural5.4 neural5.5) model-1-in-5-out (in) (lbl5.1 lbl5.2 lbl5.3 lbl5.4 lbl5.5)]
                                           [(neural7.1 neural7.2 neural7.3 neural7.4 neural7.5 neural7.6 neural7.7) model-1-in-7-out (in) (lbl7.1 lbl7.2 lbl7.3 lbl7.4 lbl7.5 lbl7.6 lbl7.7)]
                                           [(neural9.1 neural9.2 neural9.3 neural9.4 neural9.5 neural9.6 neural9.7 neural9.8 neural9.9) model-1-in-9-out (in) (lbl9.1 lbl9.2 lbl9.3 lbl9.4 lbl9.5 lbl9.6 lbl9.7 lbl9.8 lbl9.9)]
                                           [(neural11.1 neural11.2 neural11.3 neural11.4 neural11.5 neural11.6 neural11.7 neural11.8 neural11.9 neural11.10 neural11.11) model-1-in-11-out (in) (lbl11.1 lbl11.2 lbl11.3 lbl11.4 lbl11.5 lbl11.6 lbl11.7 lbl11.8 lbl11.9 lbl11.10 lbl11.11)]
                                           [(neural13.1 neural13.2 neural13.3 neural13.4 neural13.5 neural13.6 neural13.7 neural13.8 neural13.9 neural13.10 neural13.11 neural13.12 neural13.13) model-1-in-13-out (in) (lbl13.1 lbl13.2 lbl13.3 lbl13.4 lbl13.5 lbl13.6 lbl13.7 lbl13.8 lbl13.9 lbl13.10 lbl13.11 lbl13.12 lbl13.13)]
                                           [(neural15.1 neural15.2 neural15.3 neural15.4 neural15.5 neural15.6 neural15.7 neural15.8 neural15.9 neural15.10 neural15.11 neural15.12 neural15.13 neural15.14 neural15.15) model-1-in-15-out (in) (lbl15.1 lbl15.2 lbl15.3 lbl15.4 lbl15.5 lbl15.6 lbl15.7 lbl15.8 lbl15.9 lbl15.10 lbl15.11 lbl15.12 lbl15.13 lbl15.14 lbl15.15)]
                                           [(neural17.1 neural17.2 neural17.3 neural17.4 neural17.5 neural17.6 neural17.7 neural17.8 neural17.9 neural17.10 neural17.11 neural17.12 neural17.13 neural17.14 neural17.15 neural17.16 neural17.17) model-1-in-17-out (in) (lbl17.1 lbl17.2 lbl17.3 lbl17.4 lbl17.5 lbl17.6 lbl17.7 lbl17.8 lbl17.9 lbl17.10 lbl17.11 lbl17.12 lbl17.13 lbl17.14 lbl17.15 lbl17.16 lbl17.17)]
                                           [(neural19.1 neural19.2 neural19.3 neural19.4 neural19.5 neural19.6 neural19.7 neural19.8 neural19.9 neural19.10 neural19.11 neural19.12 neural19.13 neural19.14 neural19.15 neural19.16 neural19.17 neural19.18 neural19.19) model-1-in-19-out (in) (lbl19.1 lbl19.2 lbl19.3 lbl19.4 lbl19.5 lbl19.6 lbl19.7 lbl19.8 lbl19.9 lbl19.10 lbl19.11 lbl19.12 lbl19.13 lbl19.14 lbl19.15 lbl19.16 lbl19.17 lbl19.18 lbl19.19)])
                             (super-new)))

(define inter-object-class% (class object%
                              (field [a 1])
                              (label-field [lbl1 5] [lbl2 5] [lbl3 5] [lbl4 5] [lbl5 5] [lbl6 5] [lbl7 5] [lbl8 5] [lbl9 5] [lbl10 5] [lbl11 5] [lbl12 5] [lbl13 5] [lbl14 5] [lbl15 5] [lbl16 5] [lbl17 5] [lbl18 5] [lbl19 5])
                              (external-neural-field external-neural external-neural2 external-neural3 external-neural4 external-neural5 external-neural6 external-neural7
                                                     external-neural8 external-neural9 external-neural10 external-neural11 external-neural12 external-neural13 external-neural14
                                                     external-neural15 external-neural16 external-neural17 external-neural18 external-neural19)
                              (super-new)))


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