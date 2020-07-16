(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload :cl-py-generator))

(in-package :cl-py-generator)

(defparameter *path* "/home/martin/stage/cl-py-finance/")

(let* ((code
	`(do0
	  "#!/usr/bin/env python3"
	  
	  (do0
	   (imports (
		     datetime
		     calendar
		     (pd pandas)
		     (np numpy)
		     time
		     pathlib
		     re
		     requests)))
	  (do0
	   (setf stocks (list ,@(loop for e in `(LITE NVDA AMD ASML INTC BDX) collect
				     `(string ,e))))
	   )
	  ))
       )
  (write-source (format nil "~a/source/run_02_nasdaq_poll" *path*)
	 code))
