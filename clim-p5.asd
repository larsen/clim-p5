;;;; clim-p5.asd

(asdf:defsystem #:clim-p5
  :description "Describe clim-p5 here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:mcclim)
  :components ((:file "package")
               (:file "clim-p5")))
