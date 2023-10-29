#include "ros/ros.h"
#include "ball_chaser/DriveToTarget.h"
#include <sensor_msgs/Image.h>

// Define a global client that can request services
ros::ServiceClient client;

// This function calls the command_robot service to drive the robot in the specified direction
void drive_robot(float lin_x, float ang_z)
{
    // TODO: Request a service and pass the velocities to it to drive the robot
    ros::NodeHandle n;

    ros::ServiceClient client = n.serviceClient<ball_chaser::DriveToTarget>("/ball_chaser/command_robot");

    ball_chaser::DriveToTarget ball_chaser_srv;

    ball_chaser_srv.request.linear_x = lin_x;
    ball_chaser_srv.request.angular_z = ang_z;

    if (client.call(ball_chaser_srv))
    {
        // Service call succeeded
    }
    else
    {
        // Service call failed
    }
}

// This callback function continuously executes and reads the image data
void process_image_callback(const sensor_msgs::Image img)
{

    int white_pixel = 255;
    
    // TODO: Loop through each pixel in the image and check if there's a bright white one
    // Then, identify if this pixel falls in the left, mid, or right side of the image
    // Depending on the white ball position, call the drive_bot function and pass velocities to it
    // Request a stop when there's no white ball seen by the camera
    bool ball_found = false;
    int left = img.step / 3;
    int center = 2*left;
    int detect_position_ball = -1; // -1: not found, 0: left, 1: mid, 2: right

    // Loop through each pixel in the image and check if it's equal to the white pixel
    for(int i = 0; i < img.height; i++)
    {   
        int row_offset = i*img.step;
	
        for(int j = 0; j < img.step; j += 3)
        {
            // Search for a white pixel in array 
            if ((img.data[row_offset + j] == white_pixel) && (img.data[row_offset + j + 1] == white_pixel) && (img.data[row_offset + j + 2] == white_pixel))
            {
		int residue = j%img.step;
		// Check the sector
		ball_found = true;
		// Determine the ball position based on the pixel index
		if (residue < left)
			detect_position_ball = 0; // Left position	
		else if (residue < center)
			detect_position_ball = 1; // Mid position	
		else
			detect_position_ball = 2; // Right position
		break;
            }        
        }
    }

    // Depending on the ball position, call the drive_robot function and pass velocities to it
    if (ball_found) 
    {
    	if (detect_position_ball == 0)
            drive_robot(0.5, 0.3); // Velocities for when car turn left
        else if (detect_position_ball == 1)
            drive_robot(0.5, 0.0); // Velocities for go straight
        else if (detect_position_ball == 2)
            drive_robot(0.5, -0.3); // Velocities for when car turn right
    } 
    else
    {
        // Stop when can not find ball
        drive_robot(0.0, 0.0); // Stop the robot
    }
}

int main(int argc, char** argv)
{
    // Initialize the process_image node and create a handle to it
    ros::init(argc, argv, "process_image");
    ros::NodeHandle n;

    // Define a client service capable of requesting services from command_robot
    client = n.serviceClient<ball_chaser::DriveToTarget>("/ball_chaser/command_robot");

    // Subscribe to /camera/rgb/image_raw topic to read the image data inside the process_image_callback function
    ros::Subscriber sub1 = n.subscribe("/camera/rgb/image_raw", 10, process_image_callback);

    // Handle ROS communication events
    ros::spin();

    return 0;
}
