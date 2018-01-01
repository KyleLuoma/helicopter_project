/// @description Insert description here
// Check if helo is within bounds of surface_array coverage and find AGL values for left and right side of sprite:
if self.bbox_right >= 0 && self.bbox_left >= 0 {
	AGL_R = global.surface_array[bbox_right] - self.bbox_bottom;
	AGL_L = global.surface_array[bbox_left] - self.bbox_bottom;
}

//If helicopter is in ground effect condition, calculate ground effect force using AGL value and IGE multiplier:
if (self.bbox_left > 0 && self.bbox_left < array_length_1d(global.surface_array)) &&
	(self.rotor_torque > 0) && (AGL_R <= IGE_threshold || AGL_L <= IGE_threshold) {
	IGE_value = ((1 - (min(AGL_L, AGL_R) / IGE_threshold)) * IGE_multiplier) - min(abs(self.phy_speed_x), IGE_multiplier);
} else {
	IGE_value = 0;
}

//If speed exceeds ITL thrushold, apply ETL forces:
if self.phy_speed_x > ETL_threshold {
	ETL_value = ETL_effect;
} else {
	ETL_value = 0;
}

//Apply vertical force variables to helo object:
physics_apply_local_force(0,21,0,-1 * (torque_multiplier * rotor_torque + IGE_value + ETL_value));
