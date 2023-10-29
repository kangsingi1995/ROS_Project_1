;; Auto-generated. Do not edit!


(when (boundp 'my_robot::DriveToTarget)
  (if (not (find-package "MY_ROBOT"))
    (make-package "MY_ROBOT"))
  (shadow 'DriveToTarget (find-package "MY_ROBOT")))
(unless (find-package "MY_ROBOT::DRIVETOTARGET")
  (make-package "MY_ROBOT::DRIVETOTARGET"))
(unless (find-package "MY_ROBOT::DRIVETOTARGETREQUEST")
  (make-package "MY_ROBOT::DRIVETOTARGETREQUEST"))
(unless (find-package "MY_ROBOT::DRIVETOTARGETRESPONSE")
  (make-package "MY_ROBOT::DRIVETOTARGETRESPONSE"))

(in-package "ROS")





(defclass my_robot::DriveToTargetRequest
  :super ros::object
  :slots (_linear_x _angular_z ))

(defmethod my_robot::DriveToTargetRequest
  (:init
   (&key
    ((:linear_x __linear_x) 0.0)
    ((:angular_z __angular_z) 0.0)
    )
   (send-super :init)
   (setq _linear_x (float __linear_x))
   (setq _angular_z (float __angular_z))
   self)
  (:linear_x
   (&optional __linear_x)
   (if __linear_x (setq _linear_x __linear_x)) _linear_x)
  (:angular_z
   (&optional __angular_z)
   (if __angular_z (setq _angular_z __angular_z)) _angular_z)
  (:serialization-length
   ()
   (+
    ;; float64 _linear_x
    8
    ;; float64 _angular_z
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _linear_x
       (sys::poke _linear_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _angular_z
       (sys::poke _angular_z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _linear_x
     (setq _linear_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _angular_z
     (setq _angular_z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass my_robot::DriveToTargetResponse
  :super ros::object
  :slots (_msg_feedback ))

(defmethod my_robot::DriveToTargetResponse
  (:init
   (&key
    ((:msg_feedback __msg_feedback) "")
    )
   (send-super :init)
   (setq _msg_feedback (string __msg_feedback))
   self)
  (:msg_feedback
   (&optional __msg_feedback)
   (if __msg_feedback (setq _msg_feedback __msg_feedback)) _msg_feedback)
  (:serialization-length
   ()
   (+
    ;; string _msg_feedback
    4 (length _msg_feedback)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _msg_feedback
       (write-long (length _msg_feedback) s) (princ _msg_feedback s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _msg_feedback
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _msg_feedback (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass my_robot::DriveToTarget
  :super ros::object
  :slots ())

(setf (get my_robot::DriveToTarget :md5sum-) "c8652349d2a34a90a09475339e2a93d9")
(setf (get my_robot::DriveToTarget :datatype-) "my_robot/DriveToTarget")
(setf (get my_robot::DriveToTarget :request) my_robot::DriveToTargetRequest)
(setf (get my_robot::DriveToTarget :response) my_robot::DriveToTargetResponse)

(defmethod my_robot::DriveToTargetRequest
  (:response () (instance my_robot::DriveToTargetResponse :init)))

(setf (get my_robot::DriveToTargetRequest :md5sum-) "c8652349d2a34a90a09475339e2a93d9")
(setf (get my_robot::DriveToTargetRequest :datatype-) "my_robot/DriveToTargetRequest")
(setf (get my_robot::DriveToTargetRequest :definition-)
      "float64 linear_x
float64 angular_z
---
string msg_feedback

")

(setf (get my_robot::DriveToTargetResponse :md5sum-) "c8652349d2a34a90a09475339e2a93d9")
(setf (get my_robot::DriveToTargetResponse :datatype-) "my_robot/DriveToTargetResponse")
(setf (get my_robot::DriveToTargetResponse :definition-)
      "float64 linear_x
float64 angular_z
---
string msg_feedback

")



(provide :my_robot/DriveToTarget "c8652349d2a34a90a09475339e2a93d9")


