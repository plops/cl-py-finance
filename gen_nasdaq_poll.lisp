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
	   (setf headers (dict ,@(loop for (k v) in `((authority api.nasdaq.com)
						      (accept "application/json, text/plain, */*")
						      (user-agent "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Mobile Safari/537.36")
						      (origin "https://www.nasdaq.com")
						      (sec-fetch-site "same-site")
						      (sec-fetch-mode  "cors")
						      (sec-fetch-dest "empty")
						      (referer 
						       "https://www.nasdaq.com/market-activity/stocks/lite/latest-real-time-trades")
						      (accept-language "en-US,en;q=0.9"))
				    collect
				      `((string ,k) (string ,v)))))
	   (setf params (tuple (tuple (string "") (string ""))
			       (tuple (string "limit") (string "20"))
			       (tuple (string "fromTime") (string "00:00"))))
	   )
	  ))
       )
  (write-source (format nil "~a/source/run_02_nasdaq_poll" *path*)
	 code))
