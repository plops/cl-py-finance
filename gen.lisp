(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload :cl-py-generator))

(in-package :cl-py-generator)

(defparameter *path* "/home/martin/stage/cl-py-finance/")


;; install a webextension in browser instance:
;; https://intoli.com/blog/firefox-extensions-with-selenium/
;; intercept xhr web requests:
;; https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Intercept_HTTP_requests
;; https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/WebRequest
;; onCompleted
;; URL: https://query1.finance.yahoo.com/v8/finance/chart/NVD.F?region=US&lang=en-US&includePrePost=false&interval=2m&range=1d&corsDomain=finance.yahoo.com&.tsrc=finance
;; cd store_webrequest; zip /tmp/store_webrequest.xpi *.js *.json
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
	   (do0
	     ;; disable image loading
	    (setf firefox_profile (selenium.webdriver.FirefoxProfile))
	    ;; this is not working in firefox after 2014 or so
	     #+nil (firefox_profile.set_preference (string "permissions.default.image")
					     2))
	   (do0 ;; open browser and log in
	    (setf driver (selenium.webdriver.Firefox :firefox_profile firefox_profile)
		  wait (selenium.webdriver.support.wait.WebDriverWait driver 30))
	    
	    (do0 
	     ;; install extension
	     (driver.install_addon (string "/tmp/store_webrequest.xpi")
				  :temporary True))
	    (driver.get (string "https://finance.yahoo.com/quote/NVD.F")
			)
	    ;; click away the cookie notification
	    (dot (sel (string ".btn.primary"))
		 (click))
	   
	    #+ni (dot (sel (string ".btn-google")) ;; click google
		 (click))

	    #+ni (dot (waitsel (string "#identifierId")) ;; enter email
		 (send_keys (string "bla"))))
	   
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
