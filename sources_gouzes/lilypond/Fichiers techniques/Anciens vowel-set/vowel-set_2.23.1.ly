#(define vowel-set 
   (list->char-set 
    (string->list "AEIOUYÁÀÄÂÉÈÊÍÌÏÎÓÒÖÔÚÙÜÛŒÆØaeiouyáàäâéèëêíìïîóòöôúùüûœæ")))

#(define space-set
   (list->char-set 
    (string->list " _—.?-;,:\"'“”‘’–— */()[]{}|<>!`~&…")))

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

#(define (center-on-vowel grob)              
   (let* ((text (ly:grob-property-data grob 'text))
          (syllable (markup->string text))
          (vowel-position  
           (if (string-index syllable vowel-set)
               (string-index syllable vowel-set)
               0))
          (decal
           (cond
            ((contient syllable "gu") 1)
            ((contient syllable "qu'") 2)
            ((contient syllable "qu") 1)
            (else 0)))
          (vowel-position (+ decal vowel-position))
          (prevowel (substring syllable 0 vowel-position))
          ;(vowel-end
          ; (if (string-index-right syllable vowel-set)
          ;     (1+ (string-index-right syllable vowel-set))
          ;     (string-length syllable)))
          ;(vowel (substring syllable vowel-position vowel-end))
          (vowel (substring syllable vowel-position (+ 1 vowel-position)))
          (prevowel-width (width grob prevowel))
          (vowel-width (width grob vowel))
          (syllable-width (width grob syllable))
          (note-column (ly:grob-parent grob X))
          (note-column-extent (ly:grob-extent note-column note-column X))
          (note-column-width (interval-length note-column-extent)))
     ;(display (width grob prevowel))
     (if (<= (string-length syllable) 3)
         (/ (- note-column-width syllable-width) 2)
         (- (/ (- note-column-width vowel-width) 2)
            prevowel-width)
         )))

#(define (centrer grob)
   (let* ((text (ly:grob-property-data grob 'text))
          (syllable (markup->string text))
          (word-position
           (if (string-skip syllable space-set)
               (string-skip syllable space-set)
               0))
          (word-end
           (if (string-skip-right syllable space-set)
               (+ (string-skip-right syllable space-set) 1)
               (string-length syllable)))
          (preword (substring syllable 0 word-position))
          (word (substring syllable word-position word-end))
          (preword-width (width grob preword))
          ;(word-width (width grob (if (string-null? syllable) text word)))
          (word-width (width grob word))
          (note-column (ly:grob-parent grob X))
          (note-column-extent (ly:grob-extent note-column note-column X))
          (note-column-width (interval-length note-column-extent))
          ;(self-X (ly:grob-property-data grob 'self-alignment-X))
          )
     ;(display (width grob preword))
     (-
      (*
       (/ (- note-column-width word-width) 2)
       ;(1+ (if (procedure? self-X) (self-X grob) self-X)
       )
      preword-width)))

#(define (center-on-second grob)              
   (let* ((text (ly:grob-property-data grob 'text))
          (syllable (markup->string text))
          (prevowel (substring syllable 0 1))
          (vowel (if (= (string-length syllable) 1)
                     (substring syllable 0 1)
                     (substring syllable 1 2)
                     ))
          (prevowel-width (width grob prevowel))
          (vowel-width (width grob vowel))
          (syllable-width (width grob syllable))
          (note-column (ly:grob-parent grob X))
          (note-column-extent (ly:grob-extent note-column note-column X))
          (note-column-width (interval-length note-column-extent)))
     (if (<= (string-length syllable) 3)
         (/ (- note-column-width syllable-width) 2)
         (- (/ (- note-column-width vowel-width) 2)
            prevowel-width)
         )))