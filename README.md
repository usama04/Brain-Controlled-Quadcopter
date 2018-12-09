# Brain-Controlled-Quadcopter
This work consists of an F450 frame based quadcopter with APM 2.8 controller. Its Roll and Pitch were controlled using a P300 speller.

P300 speller is a remarkable software which uses EEG to identify the character that the operater wants to type. This system was already implemented on OpenVIBE.
The box file which visualises the P300 speller on OpenVIBE has been modified to save the detected character in the sketchbook folder of pwm_control_desktop_app

The pwm_control_desktop_app is java code which runs on processing. It is a control pannel for our DIY quadcopter. It reads the character in the Results.txt file and sends the corresponding commands to the quadcopter using bluetooth.

The Quadcopter end reciever was custom made. It consists of an HC-05 bluetooth module and an arduino nano. It recieves the signals of character type via bluetooth from the pwm_control_desktop_app and then generates the corresponding pwm on the input ports of the APM 2.8.

APM 2.8 was configured using APM planner for ubuntu and its PWM values were configured using the throttle slidebar in the pwm_control_desktop_app.
