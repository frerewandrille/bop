#(define vowel-set (list->char-set (string->list "AEIOUYÅÁÀÄÂÉÈÍÌÏÎÓÒÖÔÚÙÜÛŒÆØaeiouyåáàäâéèëíìïîóòöôúùüûœæø"))) 

#(define (width grob text-string)
  (let* ((layout (ly:grob-layout grob))
         (props (ly:grob-alist-chain grob (ly:output-def-lookup layout 'text-font-defaults))))
         (cdr (ly:stencil-extent (ly:text-interface::interpret-markup layout props (markup text-string)) X))))


#(define (center-on-vowel grob)              
  (let* ((syllable (ly:grob-property-data grob 'text))
         (vowel-count (string-count syllable vowel-set)) 
         (vowel-position (string-index syllable vowel-set)) 
         (prevowel (substring syllable 0 vowel-position))
         (vowel (substring syllable vowel-position (+ vowel-position 1)))
         (prevowel-width (width grob prevowel))
         (vowel-width (width grob vowel))
; TODO: get the note width dynamically instead of hard coded
         (note-width (interval-length (ly:grob-property (ly:grob-parent grob X) 'X-extent))))

  (- (/ (- note-width vowel-width) 2) prevowel-width)))
