; Challenge 2: TLang - Tuenti Programming Contest
; Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
; Usage: clj challenge02.clj
; Comments: Why Clojure? When I read the statement I thought: this guys want
;  I write a parser... but hey! that is polish notation! Why reinvent the wheel
;  when there are programming languages like Scheme, Clojure or Haskell that
;  support it natively? Note: These have been my first thee lines in Clojure.

(doseq [line (line-seq (java.io.BufferedReader. *in*))] 
  (println (eval (read-string
    (.replace(.replace(.replace(.replace line "^=" "(+") "^#" "(*") "^@" "(-") "$" ")")))))
