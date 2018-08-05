;; some analysis by kilian has shown that this file
;; is probably not compiled and loaded by the system
;; so it is marked as __not-loaded__

(in-package :ccl)

(make-instance 'capi:column-layout
               :title "ENP score notation"
               :title-position :top
               :description
               (list (make-instance 'ccl::enp-tutorial-text-pane :text

                                    "ENP-score-notation is a text-based format to represent ENP scores. It is based on the hierarchical score structure of ENP. ENP-score-notation offers a large subset of definable attributes. The syntax is designed so that it also allows to add new features easily. The current subset, however, should be large enough for most practical purposes. The Lisp list format allows a straightforward way to generate and manipulate musical data.

Syntax

The structure of ENP-score-notation reflects the hierarchical structure of the score. The syntax is similar to the LISP list syntax and also resembles CLOS in the way the optional keyword arguments are given.
The basic syntax of ENP-score-notation describes only the rhythmic skeleton along with the overall structure of the score (i.e., parts, voices, measures, etc.). All other information (including pitches) is defined as optional keyword arguments. For example, in its simplest form, a triplet is notated as (1 (1 1 1)). The pitch information can be added by using a keyword :notes, e.g., (1 ((1 :notes (60 64 67)) (1 :notes (60 64 67)) (1 :notes (60 64 67)))). Pitches in ENP are generally represented as midi values, 60 being c1, i.e., middle C. However, ENP can also represent microtones. They are notated by adding the relevant decimal fraction to the midi value. Thus, 60.5 would be c1 raised by 1/4 (half a semitone).

Expressions

Expressions can be incorporated into ENP-score-notation by using a keyword :expressions followed by a list of expressions and possible initialization options. Expressions are identified by using an appropriate keyword indicating the class of the expression. Among valid expression keywords are, for example, :group, :slur, :bpf, :accent, :staccato, etc. In case of group expressions the keywords usually contain an additional numeral that indicates the instance identity of the expression. The instance identity numeral is used to distinguish between different instances of group-expressions (in case of overlapping slurs, for example). Thus, :slur/1 indicates an ENP expression of class 'slur' with the identity value '1'. All subsequent references to :slur/1 point to the same instance. Furthermore, when an expression is introduced for the first time, any number of initialization options can be supplied. This information consists of keyword and value pairs defining any additional properties of the expression. 

See Manuals section of this documentation for a list of ENP-score-notation attributes.
")))
