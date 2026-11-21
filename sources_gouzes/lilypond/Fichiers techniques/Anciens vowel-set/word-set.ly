#(define vowel-set (list->char-set (string->list "AEIOUYÁÀÄÂÉÈÊÍÌÏÎÓÒÖÔÚÙÜÛŒÆØaeiouyáàäâéèëêíìïîóòöôúùüûœæ")))

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
          (syl-width (width grob syllable))
          (vowel-position  
           (if (string-index syllable vowel-set)
               (string-index syllable vowel-set)
               0))
          (vowel-end
           (if (string-index-right syllable vowel-set)
               (1+ (string-index-right syllable vowel-set))
               (string-length syllable)))
          (decal
           (cond
            ((contient syllable "gu") 1)
            ((contient syllable "qu'") 2)
            ((contient syllable "qu") 1)
            (else 0)))
          (vowel-position (+ decal vowel-position))
          (prevowel (substring syllable 0 vowel-position))
          (vowel (substring syllable vowel-position vowel-end))
          (prevowel-width (width grob prevowel))
          (vowel-width (width grob vowel))
          (note-column (ly:grob-parent grob X))
          (note-column-extent (ly:grob-extent note-column note-column X))
          (note-column-width (interval-length note-column-extent)))
     (- prevowel-width)))