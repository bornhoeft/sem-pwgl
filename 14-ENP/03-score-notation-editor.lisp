;; some analysis by kilian has shown that this file
;; is probably not compiled and loaded by the system
;; so it is marked as __not-loaded__

(in-package :ccl)

(let ((templates
       '(("Choose a Template..."
          "Use the menu above to choose a template to work with. You can start by experimenting with the numerical values. 
The 'Update' button can be used preview the resulting score at the bottom of the window.
Messages view, in turn, displays short a description in case there are errors in the score notation code.")

         ("Score Structure"
          ";The keyword pairs :begin + :score/:part1/:measure1 are not part of ENP-score-notation. They are used here only to clarify the structure by denoting the beginning of each of the levels in the score hierarchy. They can and should be omitted. This example is, however, fully functional as ENP discards all unknown keywords.

(:begin :score
 (:begin :part1  
  (:begin :voice1
   (:begin :measure1
    (4 (-1)))
   (:begin :measure2
    (2 (-1)) (2 ((1 :notes ((87 :enharmonic :flat) 93 98) :expressions (:8va))))))
  (:begin :voice2
   (:begin :measure1
    (4 (-1)))
   (:begin :measure2
    (4 ((1 :notes ((70 :enharmonic :flat) 81)))))))
 (:begin :part2
  :staff :bass-staff 
  (:begin :voice1
   (:begin :measure1
    (2 (-1))
    (2 ((1 :notes (60 64) :expressions (:accent)))))
   (:begin :measure2
    (4 ((1.0 :notes (60 64))))))
  (:begin :voice2
   (:begin :measure1
    (4 ((1 :notes (42 49) :expressions (:accent :f/1)))))
   (:begin :measure2
    (4 ((1.0 :notes (42 49))))))))")

         ( "Two voiced part"
           "(:key-signature :G-major
 ((((4 ((1 :notes (67)) (1 :notes (69)) (1 :notes (71)) (1 :notes (67))))))
  (((4 ((2 :notes (64)) (2 :notes (62))))))))")

         ( "Feathered Beats"
           "(:spacing 0.33
 ((((1 (1 1 1 1 1 1 1) :class :accelerando-beat)
    (1 (1 1 1 1 1 1 1) :class :ritardando-beat)))))")

         ( "Grace Beats"
           "(((((1 (1 1) :class :grace-beat)
    (1 (1 1 1))
    (1 ((1 (1 1)) (1 (1 1 1) :class :grace-beat) (1 (1))))))))")

         ( "Mensural"
           "((:instrument \"alto saxophone\"
  :staff :treble-staff
  (((2
     ((1 :notes (52) :expressions ((:slur/1 :slope -6.0) :pp/1))))
    (1
     ((1.0
       :notes (52) :expressions (:slur/1))
      (1 :notes ((58 :enharmonic 1)) :expressions (:slur/1))
      (1 :notes (59) :expressions (:slur/1))
      (1 :notes (62) :expressions (:slur/1))))
    (1
     ((1 :notes ((63 :enharmonic 1)) :expressions  (:slur/1 :crescendo/1))
      (1 :notes (65)  :expressions  (:crescendo/1))
      (1 :notes ((66 :enharmonic 1)) :expressions  (:crescendo/1))
      (1  :notes ((68 :enharmonic 1))  :expressions  (:crescendo/1))
      (1   :notes (69) :expressions  (:crescendo/1))))
    (1
     ((1  :notes (72)  :expressions  (:slur/1 :f/1))
      (1 :x-offset 1.0  :notes  ((73 :enharmonic 1)) :expressions (:slur/1 :f/1))
      (6  :x-offset 2.0 :notes (79) :expressions (:f/1))))))))")

         ( "Non-mensural"
           "((((0.2 :notes ((60 :offset-time -0.15) (66 :offset-time 0.0) (71 :offset-time 0.15))
        :expressions ((:crescendo/1 :initial-dynamics :p :end-dynamics :f)))
   (0.5 :notes (77) :expressions (:crescendo/1)))))"))))
(make-instance 'capi:column-layout
               :title ()
               :title-position :top
               :description
               (list (make-instance 'capi:row-layout
                                    :description (list (make-instance 'capi::option-pane
                                                                      :selection-callback #'(lambda(data container)
                                                                                              (let ((text-input-pane
                                                                                                     (second (capi::layout-description
                                                                                                              (current-tutorial-pane container)))))
                                                                                                (execute-without-interrupts (editor:process-character 
                                                                                                                     (list #'(setf capi:editor-pane-text)
                                                                                                                           (second data)
                                                                                                                           text-input-pane)
                                                                                                                     (capi:editor-window text-input-pane))))
                                                                                              (make-tutorial-test-score-silently :default container))
                                                                      :visible-max-width 140
                                                                      :items templates
                                                                      :print-function #'first)
                                                       (make-instance 'capi:button :text "Redisplay"
                                                                      :callback 'make-tutorial-test-score-silently)
                                                       
                                                       (make-instance 'capi:button :text "Reset"
                                                                      :callback #'(lambda(data container) (make-tutorial-test-score-silently :default container)))))
                     (make-instance 'capi::editor-pane
                                    :visible-min-height 320
                                    :buffer (string "_ENP-tutorial-buffer_#sdhfj323jwke")
                                    :buffer-modes '("lisp")
                                    :vertical-scroll t
                                    :text (second (first templates)))
                     (make-instance 'capi::title-pane
                                    :foreground :red
                                    :title "Warnings:"
                                    :text "...")
                     (make-instance 'capi:simple-layout
                                    :vertical-scroll t
                                    :enabled ()
                                    :width 720
                                    :title ()
                                    :visible-min-width 700
                                    ;:visible-min-height 350
                                    :background :white
                                    :description (list (make-instance 'enp-window :parts (list (make-part ()))))))))