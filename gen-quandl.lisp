(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload :cl-py-generator))

(in-package :cl-py-generator)

(progn
  (defparameter *path* "/home/martin/stage/cl-py-finance/")

  (let* ((code
	  `(do0
	    "#!/usr/bin/env python3"
	    
	    (do0
	     (imports (quandl
		       datetime
		       calendar
		       (pd pandas)
		       (np numpy)
		       time
		       pathlib
		       re)))

	    ))
	 )
    (write-source (format nil "~a/source/run_01_quandl_get_stock" *path*)
		  code)))
