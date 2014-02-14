(in-package :cl-psara)

(defun init-logged-in-toolbar-style ()
  (hunchentoot:define-easy-handler (toolbarstyle :uri "/toolbar.css") ()
    (setf (hunchentoot:content-type*) "text/css")
    (format nil "~a"
	    (css-lite:css (("ul, li")
			   (:display "inline"
			    :padding "0"
			    :margin "0"))
			  ((".toolbaritem")
			   (:padding-left "5px"
			    :padding-right "5px"))
			  (("div#usertoolbar")
			   (:border "1px solid #AAAACC"
			    :border-radius "25px 25px 25px 25px"
			    :background "#BBBBDD"
			    :margin-bottom "5px"))))))

(defun init-logged-in-toolbar ()
  (hunchentoot:define-easy-handler (toolbar :uri "/toolbar") (uname)
    (setf (hunchentoot:content-type*) "text/html")
;    (let* ((session (hunchentoot:start-session))
;	   (cookie (hunchentoot:cookie-out "hunchentoot-session"))
;	   (uname (hunchentoot:session-value 'uname session)))
      (format nil "~a"
	      (markup:markup
	       (:head
		(:link :rel "stylesheet" :type "text/css" :href "/toolbar.css"))
	       (:body
		(:div :id "usertoolbar"
		      (:ul
		       (:li :class "toolbaritem"
			    "logged in as " uname)
		       (:li :class "toolbaritem"
			    (:a :href "/weblogform" "new-entry"))
		       (:li :class "toolbaritem"
			    (:a :href "/searchform" "search"))
		       (:li :class "toolbaritem"
			    (:a :href "/adminpanel" "admin-panel"))
		       (:li :class "toolbaritem"
			    (:a :href "/logout" "logout")))))))))

(defun +init-toolbar+ ()
  (init-logged-in-toolbar-style)
  (init-logged-in-toolbar))