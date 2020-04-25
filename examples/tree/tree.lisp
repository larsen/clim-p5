;;;; tree.lisp

(in-package #:tree)

(defun init ()
  (print "OK."))

(defun display (canvas)
  (branch canvas 0 200 50 0))

(defun branch (canvas x y length direction)
  (if (> length 2)
      (let ((growth-factor 0.60)
            (dest-x (+ x (* length (cos direction))))
            (dest-y (+ y (* length (sin direction)))))
        (draw-line* canvas x y dest-x dest-y
                    :ink (if (> length 10)
                             +brown+
                             +green+)
                    :line-thickness (* length 0.1))
        ;; Branch left
        (branch canvas
                dest-x dest-y
                (* length growth-factor)
                (+ direction 0.6))
        ;; Branch right
        (branch canvas
                dest-x dest-y
                (* length growth-factor)
                (+ direction -0.6)))))

(defun update ()
  (print "update."))

(clim-p5:run :init 'init
     :draw 'display
     :update 'update)
