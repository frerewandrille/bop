#(define vowel-set (list->char-set (string->list "AEIOUYÁÀÄÂÉÈÊÍÌÏÎÓÒÖÔÚÙÜÛŒÆØaeiouyáàäâéèëêíìïîóòöôúùüûœæ"))) 

#(define (width grob text)
  (let* ((X-extent (ly:stencil-extent (grob-interpret-markup grob text) X)))
         (if (interval-empty? X-extent)
             0 
       	     (cdr X-extent))))

#(define (center-on-vowel grob)              
  (let* ((syllable (ly:grob-property-data grob 'text))
         (vowel-count (string-count syllable vowel-set)) 
         (vowel-position (string-index syllable vowel-set)) 
         (prevowel (substring syllable 0 vowel-position))
         (vowel (substring syllable vowel-position (+ vowel-position 1)))
         (prevowel-width (width grob prevowel))
         (vowel-width (width grob vowel))
         (note-column (ly:grob-parent grob X))
         (note-column-extent (ly:grob-extent note-column note-column X))
         (note-column-width (interval-length note-column-extent)))
         
   (- (/ (- note-column-width vowel-width) 2) prevowel-width)))
