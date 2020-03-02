(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload :cl-py-generator))

(in-package :cl-py-generator)

(progn
  (defparameter *path* "/home/martin/stage/cl-py-finance/")

  (let* ((code
	  `(do0
	    "#!/usr/bin/env python3"
	    "# pip3 install --user mplfinance"
	    (do0
	     (do0
	      (imports ((plt matplotlib.pyplot)
			(mpf mplfinance)))
	      (plt.ion))
	     (imports (quandl
		       datetime
		       calendar
		       (pd pandas)
		       (np numpy)
		       time
		       pathlib
		       re))

	     (do0
	      (setf f (open (string "p"))
		   pw (dot f
			   (read)
			   (replace (string "\\n")
				    (string ""))))
	      (f.close))

	     (setf quandl.ApiConfig.api_key pw)
	     (setf d (quandl.get (string "EURONEXT/ASML")
				 :start_data (string "2019-03-02")
				 )
		   d (d.rename :columns (dict ((string "Last")
					       (string "Close")))))
	     (mpf.plot d :type (string "candle")
		       :volume True))
	    ))
	 )
    (write-source (format nil "~a/source/run_01_quandl_get_stock" *path*)
		  code)))
