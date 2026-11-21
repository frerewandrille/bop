\version "2.24.0"
{
    \once \override DynamicText.after-line-breaking = #(lambda (grob)
      (let* ((x-parent (ly:grob-parent grob X))
             (orig-sten (ly:grob-property x-parent 'stencil
                          (ly:make-stencil '()))))
        (ly:grob-set-property! x-parent 'stencil
          (grob-interpret-markup x-parent #{
             \markup \combine \stencil #orig-sten
               \with-dimensions #'(0 . 0) #'(0 . 0) \vcenter
               \with-color #red \draw-line #'(0 . 6) #}))))
    c'\mf
}