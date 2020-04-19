;;;; clim-p5.lisp

(in-package #:clim-p5)

(define-application-frame main ()
  ()
  (:panes
   (canvas :application :display-function #'display)
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
  ;; TODO e` questo il posto corretto per window-clear?
  (window-clear (find-pane-named frame 'canvas))
  (funcall #'display frame (find-pane-named frame 'canvas))
  (sleep 0.1)
  (queue-event (frame-top-level-sheet frame)
                 (make-instance 'refresh-event :sheet frame)))

(define-main-command (com-start :name t :menu t) ()
  (with-application-frame (frame)
    (queue-event (frame-top-level-sheet frame)
                 (make-instance 'refresh-event :sheet frame))))

;; USER SPACE

;; (run :init #'init-function
;;      :draw #'display
;;      :update #'update)
;; TODO ^^^

;; TODO eliminare frame dalla signature
(defun display (frame pane)
  (declare (ignore frame))
  (draw-rectangle* pane 10 10 100 100 :ink +blue+)
  (draw-rectangle* pane 50 50 140 140 :ink +green+))
