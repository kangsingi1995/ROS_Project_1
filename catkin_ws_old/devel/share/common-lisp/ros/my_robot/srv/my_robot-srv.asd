
(cl:in-package :asdf)

(defsystem "my_robot-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "DriveToTarget" :depends-on ("_package_DriveToTarget"))
    (:file "_package_DriveToTarget" :depends-on ("_package"))
  ))