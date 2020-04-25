;;;; tree.asd

(asdf:defsystem #:tree
  :description "Describe tree here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:clim-p5)
  :components ((:file "package")
               (:file "tree")))
