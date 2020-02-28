(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload :cl-py-generator))

(in-package :cl-py-generator)

(defparameter *path* "/home/martin/stage/cl-py-finance/")


;; install a webextension in browser instance:
;; https://intoli.com/blog/firefox-extensions-with-selenium/
(let* ((code
	`(do0
	  "#!/usr/bin/env python3"
	  
	  (do0
	   (imports (selenium.webdriver
		     selenium.webdriver.support
		     selenium.webdriver.support.wait
		     selenium.webdriver.common.by
		     selenium.webdriver.support.expected_conditions
		     selenium.webdriver.common.keys
		     datetime
		     calendar
		     (pd pandas)
		     (np numpy)
		     time
		     pathlib
		     re)))

	  (def sel (css)
	    (return (driver.find_element_by_css_selector css)))
	  (def selx (xpath)
	    (return (driver.find_element_by_xpath xpath)))

	  (def wait_css_clickable (css)
	    (wait.until (selenium.webdriver.support.expected_conditions.element_to_be_clickable
			 (tuple selenium.webdriver.common.by.By.CSS_SELECTOR
				css))))
	  (def wait_css_gone (css)
	    (wait.until (selenium.webdriver.support.expected_conditions.invisibility_of_element_located
			 (tuple selenium.webdriver.common.by.By.CSS_SELECTOR
				css))))
	  (def wait_css_clickable (css)
	    (wait.until (selenium.webdriver.support.expected_conditions.element_to_be_clickable
			 (tuple selenium.webdriver.common.by.By.CSS_SELECTOR
				css))))
	  
	  (def waitsel (css)
	    (wait_css_clickable css)
	    
	    (return (sel css)))

	  
	  
	  
	  (do0
	   (do0 ;; open browser and log in
	    (setf driver (selenium.webdriver.Firefox)
		  wait (selenium.webdriver.support.wait.WebDriverWait driver 30))
	   
	    (driver.get (string "https://finance.yahoo.com/quote/NVD.F")
			)
	    (dot (sel (string ".btn.primary")
		      )
		 (click))
	   
	    #+ni (dot (sel (string ".btn-google")) ;; click google
		 (click))

	    #+ni (dot (waitsel (string "#identifierId")) ;; enter email
		 (send_keys (string "bla")))
	    )
	   (do0
	    #+nil (dot (waitsel (string "a[href='#/hour-registration']"))
		       (click))
	    #+nil (driver.execute_script
		   (string "document.getElementById('hour-registration-tasks-date-selection').removeAttribute('readonly',0);"))

	    #+nil
	    (date_field.send_keys selenium.webdriver.common.keys.Keys.RETURN)
	    ))))
       )
  (write-source (format nil "~a/source/run_00_get_stock" *path*)
	 code))
