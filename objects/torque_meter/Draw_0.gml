/// @description Flight instrumentation

draw_enable_drawevent(true);
x = camera_get_view_x(view_camera[0]) + 20;
draw_self();
draw_set_alpha(1);

// Torque meter:
if player_helo.rotor_torque <= 80 {	
	draw_set_colour(c_green);
} else if player_helo.rotor_torque <= 95 {
	draw_set_color(c_yellow);
} else {
	draw_set_color(c_red);
}
draw_text(x + 5, y + 2,"Torque: " + string(player_helo.rotor_torque) +"%");

// Altimeter:
draw_set_color(c_green);
draw_text(x + 5, y + 15, "Altitude: " + string(camera_get_view_height(view_camera[0]) - (player_helo.y + 23)));

// Airspeed indicator:

if player_helo.ETL_value > 0 {
	draw_set_color(c_green);
} else {
	draw_set_color(c_yellow);
}

raw_airspeed = player_helo.phy_speed_x * player_helo.h_speed_multiplier;
smoothed_airspeed = 0;
if raw_airspeed < 0.01 && raw_airspeed > -0.01 {
	smoothed_airspeed = 0;
} else {
	smoothed_airspeed = raw_airspeed
}
draw_text(x + 5, y + 30, "Airspeed: " + string(smoothed_airspeed));

//Vertical speed indicator
if player_helo.phy_speed_y < 0.01 && player_helo.phy_speed_y > -0.01 {
	v_speed = 0; 	
} else {
	v_speed = player_helo.v_speed_multiplier * player_helo.phy_speed_y;
}

if v_speed <= -800 && player_helo.AGL_R < 800 {
	draw_set_color(c_red);	
} else if v_speed <= -500 && player_helo.AGL_R < 800 {
	draw_set_color(c_yellow)
} else if v_speed > -500 {
	draw_set_color(c_green);
}
draw_text(x + 5, y + 45, "Vert Spd: " + string(v_speed));

//Display AGL altitude in yellow if OGE, green if IGE:
if player_helo.IGE_value > 0 {
	draw_set_color(c_green);
} else {
	draw_set_color(c_yellow);
}
draw_text(x + 5, y + 60, "AGL Alt: " + string(player_helo.AGL_R));

//DEBUG: Display IGE value
draw_text(x + 5, y + 75, "IGE_value: " + string(player_helo.IGE_value));
draw_text(x + 5, y + 90, "Angle: " + string(player_helo.image_angle));