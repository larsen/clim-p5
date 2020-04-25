;;;; clim-p5.lisp

(in-package #:clim-p5)

(define-application-frame main ()
  ((init-function :initarg
                  :init-function :accessor init-function)
   (update-function :initarg
                    :update-function :accessor update-function)
   (draw-function :initarg :draw-function
                  :initform (error "You must provide a DRAW-FUNCTION")
                  :accessor draw-function))
  (:panes
   (canvas :application)
   (int :interactor))
  (:layouts
   (default (vertically ()
              (4/5 canvas)
              (1/5 int))))
  (:pretty-name "CLIM")
  (:geometry :width 400 :height 500))

(define-main-command (com-quit :name t :menu t) ()
  (frame-exit *application-frame*))

;; Test other superclasses
(defclass refresh-event (window-manager-event) ())
(defmethod handle-event (frame (event refresh-event))
  (when (update-function frame)
    (funcall (symbol-function (update-function frame))))
  ;; TODO e` questo il posto corretto per window-clear?
  (window-clear (find-pane-named frame 'canvas))
  (funcall (symbol-function (draw-function frame))
           (find-pane-named frame 'canvas))
  (sleep 0.1)
  (queue-event (frame-top-level-sheet frame)
                 (make-instance 'refresh-event :sheet frame)))

(define-main-command (com-start :name t :menu t) ()
  (with-application-frame (frame)
    (when (init-function frame)
      (funcall (symbol-function (init-function frame))))
    (queue-event (frame-top-level-sheet frame)
                 (make-instance 'refresh-event :sheet frame))))

(defun run (&key init draw update)
  (run-frame-top-level
   (make-application-frame 'main
                           :init-function init
                           :update-function update
                           :draw-function draw)))

;; USER SPACE

(defun init ()
  (print "OK."))

(defun display (pane)
  (draw-rectangle* pane 10 10 100 100 :ink +red+)
  (draw-rectangle* pane 50 50 140 140 :ink +green+))

(defun update ()
  (print "update."))

(run :init 'init
     :draw 'display
     :update 'update)

