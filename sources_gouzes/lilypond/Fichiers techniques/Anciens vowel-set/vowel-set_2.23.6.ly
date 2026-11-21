\version "2.24.0"

#(define vowel-set 
   (list->char-set 
    (string->list "AEIOUYÁÀÄÂÉÈÊÍÌÏÎÓÒÖÔÚÙÜÛŒÆØaeiouyáàäâéèëêíìïîóòöôúùüûœæǽ")))

#(define space-set
   (list->char-set 
    (string->list " _—.?-;,:\"'’“”‘’–— */()[]{}|<>!`~&…")))

#(define space (list->char-set (string->list " ")))

#(define y (list->char-set (string->list "y")))

#(define apostrophe-set (list->char-set (string->list "'’")))

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

#(define (apostrophe grob)
   (let* ((text (ly:grob-property-data grob 'text))
          (texte (markup->string text))
          (lettres-debut
           (if (string-skip texte space-set)
               (string-skip texte space-set)
               0))
          (lettres-end
           (if (string-skip-right texte space-set)
               (+ 1 (string-skip-right texte space-set))
               (string-length texte)))
          (lettres (substring texte lettres-debut lettres-end))
          (mot-end
           (if  (string-index lettres space)
                (+ 1 (string-index lettres space))
                lettres-end))
          (mot (substring texte lettres-debut mot-end))
          (lettres-debut
           (if (string-index mot apostrophe-set)
               (+ 1 (string-index mot apostrophe-set) lettres-debut)
               lettres-debut))
          (mot (substring texte lettres-debut mot-end))
          (ponct (substring texte 0 lettres-debut))
          (ponct-width (width grob ponct))
          (voyelles-debut  
           (if (string-index mot vowel-set)
               (string-index mot vowel-set)
               0))
          (reste (substring mot (+ voyelles-debut 1) (string-length mot)))
          (voyelles-end
           (if (string-skip reste vowel-set)
               (+ (+ voyelles-debut (string-skip reste vowel-set)) 1)
               (string-length mot)))
          (deux-syll 
           (if (< voyelles-end (string-length mot))
               (if (string-index (substring mot (+ voyelles-end 1) (string-length mot)) vowel-set)
                   #t
                   #f)
               #f))
          (voyelles 
           (if deux-syll
               (substring mot voyelles-debut voyelles-end)
               mot))
          (voyelles-width (width grob (if (string-null? mot) text voyelles)))
          (pre-voyelles (substring mot 0 voyelles-debut))
          (pre-voyelles-width 
           (if deux-syll
               (width grob pre-voyelles)
               0))
          (note-column (ly:grob-parent grob X))
          (note-column-extent (ly:grob-extent note-column note-column X))
          (note-column-width (interval-length (ly:grob-property (ly:grob-parent grob X) 'main-extent)))
          )
     (-
      (*
       (/ (- note-column-width voyelles-width) 2)
       (if (and deux-syll (= voyelles-debut 0) (< voyelles-width note-column-width) ) 0 1 )
       )
      (+ ponct-width (- pre-voyelles-width (car note-column-extent)))
      )))

#(define (centrer grob)
   (let* ((text (ly:grob-property-data grob 'text))
          (texte (markup->string text))
          (lettres-debut
           (if (string-skip texte space-set)
               (string-skip texte space-set)
               0))
          (lettres-end
           (if (string-skip-right texte space-set)
               (+ 1 (string-skip-right texte space-set))
               (string-length texte)))
          (lettres (substring texte lettres-debut lettres-end))
          (mot-end
           (if  (string-index lettres space)
                (+ 1 (string-index lettres space))
                lettres-end))
          (mot (substring texte lettres-debut mot-end))
          (presence-qu (cond
                        ((contient mot "qu'") 3)
                        ((contient mot "Qu'") 3)
                        ((contient mot "qu’") 3)
                        ((contient mot "Qu’") 3)
                        (else 0)))
          (mot-corr (substring texte (+ lettres-debut presence-qu) mot-end))
          (voyelles-debut  
           (if (string-index mot-corr vowel-set)
               (string-index mot-corr vowel-set)
               0))
          (reste (substring mot-corr (+ voyelles-debut 1) (string-length mot-corr)))
          (voyelles-end
           (if (string-skip reste vowel-set)
               (+ (+ voyelles-debut (string-skip reste vowel-set)) 1)
               (string-length mot-corr)))
          (deux-syll 
           (if (< voyelles-end (string-length mot-corr))
               (if (string-index (substring mot (+ voyelles-end 1) (string-length mot-corr)) vowel-set)
                   #t
                   #f)
               #f))
          (pos-y
           (if (string-index mot-corr y)
               (string-index mot-corr y)
               0))
          (semi-cons 
           (if (and (< voyelles-debut pos-y) (< pos-y (- voyelles-end 1)) )
               #t
               #f))
          (voyelles-end
           (if semi-cons
               pos-y
               voyelles-end))
          (deux-syll
           (if semi-cons
               #t
               deux-syll))         
          (voyelles 
           (if deux-syll
               (substring mot-corr voyelles-debut voyelles-end)
               mot))
          (voyelles-width (width grob (if (string-null? mot) text voyelles)))
          (ponct (substring texte 0 lettres-debut))
          (ponct-width (width grob ponct))
          (pre-voyelles (substring mot 0 (+ voyelles-debut presence-qu)))
          (pre-voyelles-width 
           (if deux-syll
               (width grob pre-voyelles)
               0))         
          (note-column (ly:grob-parent grob X))
          (note-column-extent (ly:grob-extent note-column note-column X))
          (note-column-width (interval-length (ly:grob-property (ly:grob-parent grob X) 'main-extent)))
          )
     (-
      (*
       (/ (- note-column-width voyelles-width) 2)
       (if (and deux-syll (= voyelles-debut 0) (< voyelles-width note-column-width) ) 0 1 )
       )
      (+ ponct-width (- pre-voyelles-width (car note-column-extent)))
      )))

#(define (center-on-vowel grob)
   (centrer grob))


\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }
apostrophe = \once \override LyricText.X-offset = #apostrophe
retrait = \once \override LyricText.X-offset = #retrait