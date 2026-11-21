\version "2.24.0"

#(define vowel-set 
   (list->char-set 
    (string->list "AEIOUYÁÀÄÂÉÈÊÍÌÏÎÓÒÖÔÚÙÜÛŒÆØaeiouyáàäâéèëêíìïîóòöôúùüûœæ")))

#(define maj-acc
   (list->char-set 
    (string->list "ÁÀÄÂÉÈÊÍÌÏÎÓÒÖÔÚÙÜÛ")))

#(define space-set
   (list->char-set 
    (string->list " _—.?-;,:\"'’“”‘’–— */()[]{}|<>!`~&…")))

#(define space
   (list->char-set 
    (string->list " ")))

#(define (width grob text)
   (let* ((X-extent (ly:stencil-extent (grob-interpret-markup grob text) X)))
     (if (interval-empty? X-extent)
         0 
         (cdr X-extent))))

#(define (contient grob text)
   (if (string-contains grob text)
       (if (= 0 (string-contains grob text))
           #t
           #f)
       #f))

#(define (retrait grob)
   (let* ((text (ly:grob-property-data grob 'text))
          (texte (markup->string text))
          )
     (/ (width grob texte) 1.62)))

#(define (centrer grob)
   (let* ((text (ly:grob-property-data grob 'text))
          (syllabe (markup->string text))
          (lettres-position
           (if (string-skip syllabe space-set)
               (string-skip syllabe space-set)
               0))
          (ponct (substring syllabe 0 lettres-position))
          (ponct-width (width grob ponct))
          (lettres-end
           (if (string-skip-right syllabe space-set)
               (+ (string-skip-right syllabe space-set) 1)
               (string-length syllabe)))
          (lettres (substring syllabe lettres-position lettres-end))
          (mot-end
           (if  (string-index lettres space)
                (string-index lettres space)
                lettres-end))
          (mot (substring syllabe lettres-position mot-end))
          
          (voyelles-position  
           (if (string-index mot vowel-set)
               (+ (string-index mot vowel-set)
                  (if (contient mot "qu'") 2 0)
                  (if (contient mot "qu’") 2 0)
                  (if (contient mot "Qu'") 2 0)
                  (if (contient mot "Qu’") 2 0))
               0))
          (reste (substring mot (+ voyelles-position 1) (string-length mot)))
          (voyelles-end
           (if (string-skip reste vowel-set)
               (+ (+ voyelles-position (string-skip reste vowel-set)) 1)
               (string-length mot)))
          (deux-syll 
           (if (< voyelles-end (string-length mot))
               (if (string-index (substring mot (+ voyelles-end 1) (string-length mot)) vowel-set)
                   1
                   0)
               0))
          (deux-syll  
           (if (or (contient mot "qu'")
                   (contient mot "qu’")
                   (contient mot "Qu'")
                   (contient mot "Qu’"))
               1 deux-syll))
          (voyelles 
           (if (= deux-syll 1)
               (substring mot voyelles-position voyelles-end)
               mot))
          (voyelles-width (width grob (if (string-null? mot) text voyelles)))
          (pre-voyelles (substring mot 0 voyelles-position))
          (pre-voyelles-width 
           (if (= deux-syll 1)
               (width grob pre-voyelles)
               0))
          
          (note-column (ly:grob-parent grob X))
          (note-column-extent (ly:grob-extent note-column note-column X))
          (note-column-width (interval-length note-column-extent))
          (self-X (ly:grob-property-data grob 'self-alignment-X))
          )
     (display voyelles-position)
     (display " ")
     (display (+ ponct-width pre-voyelles-width (/ voyelles-width 2)))
     (display " ")
     (display syllabe)
     (display " ")
     (display (- (width grob syllabe) (+ ponct-width pre-voyelles-width (/ voyelles-width 2))))
     (display "\n")
     (-
      (*
       (/ (- note-column-width voyelles-width) 2)
       ;(1+ (ly:grob-property-data grob 'self-alignment-X))
       (if (and (= deux-syll 1) (= voyelles-position 0) (< voyelles-width note-column-width) ) 0 1 )
       )
      (+ ponct-width (- pre-voyelles-width (car note-column-extent)))
      )))