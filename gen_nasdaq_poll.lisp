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
		     time
		     calendar
		     (pd pandas)
		     (np numpy)
		     time
		     pathlib
		     re
		     requests
		     json)))
	  (do0
	   (setf symbols (list ,@(loop for e in `(LITE NVDA AMD ASML INTC BDX) collect
				     `(string ,e))))


	   (def get_ticks (symbol &key (time (string "00:00"))
				  (limit 100))
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
				(tuple (string "limit") (dot (string "{}")
							     (format limit)) ; (string "20")
				       )
				(tuple (string "fromTime") time ;(string "00:00")
				       )))

	    
	    (setf response (requests.get (dot (string "https://api.nasdaq.com/api/quote/{}/realtime-trades")
					      (format symbol))
					 :headers headers
					 :params params))
	    (setf ticks (json.loads response.text))
	    (setf df (dot (pd.DataFrame (aref (aref ticks (string "data"))
					     (string "rows")))
			  (set_index (string "nlsTime"))))
	    (setf (aref df (string "request_time")) (pd.Timestamp.now))
	    (return df))
	   (def run (&key (time (string "00:00")) (limit 20))
	     ;(print (json.dumps (get_ticks (aref symbols 0) :time time) :indent 2))
	     (print (get_ticks (aref symbols 0) :time time :limit limit))
	     )
	   )
	  ))
       )
  (write-source (format nil "~a/source/run_02_nasdaq_poll" *path*)
	 code))
