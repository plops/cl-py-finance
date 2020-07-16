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
	   (setf symbols (list ,@(loop for e in `(TSLA LITE NVDA AMD ASML INTC BDX) collect
				     `(string ,e))))


	   (def get_ticks (symbol &key (timestamp (string "00:00"))
				  (limit 100))
	     (print (dot (string "requesting last {} trades for {} ")
			 (format limit symbol)))
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
				(tuple (string "fromTime") timestamp ;(string "00:00")
				       )))

	    
	    (setf response (requests.get (dot (string "https://api.nasdaq.com/api/quote/{}/realtime-trades")
					      (format symbol))
					 :headers headers
					 :params params))
	    ;(print response.text)
	    (setf ticks (json.loads response.text))
	    (setf df #+nil (dot (pd.DataFrame (aref (aref ticks (string "data"))
					     (string "rows")))
			  (set_index (string "nlsTime")))
		  (pd.DataFrame (aref (aref ticks (string "data"))
				      (string "rows"))))
	    (setf (aref df (string "request_time")) (pd.Timestamp.now))
	    (return df))
	   (def run (&key (timestamp (string "00:00")) (limit 20))
	     ;(print (json.dumps (get_ticks (aref symbols 0) :time time) :indent 2))
	     (print (get_ticks (aref symbols 0) :timestamp timestamp :limit limit))
	     )

	   (setf symb (aref symbols 0))
	   (setf a (get_ticks symb :limit 100))
	   (time.sleep 5)
	   (setf b (get_ticks symb :limit 100))

	   (setf compare_cols (aref a.columns (list 0 1 2)))
	   (comments "find the row in b that is identical to the most recent row in a") 
	   (setf first_identical
		 (aref b
		       (dot (== (aref b compare_cols)
				(aref (dot a (aref iloc 0))
				      compare_cols))
			    (all :axis 1))))
	   )
	  ))
       )
  (write-source (format nil "~a/source/run_02_nasdaq_poll" *path*)
	 code))
