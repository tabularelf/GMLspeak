/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_io_gamepad(ffi) {
	ffi.exposeConstant( 
		"gp_face1",							gp_face1,
		"gp_face2",							gp_face2,
		"gp_face3",							gp_face3,
		"gp_face4",							gp_face4,
		"gp_shoulderl",						gp_shoulderl,
		"gp_shoulderlb",					gp_shoulderlb,
		"gp_shoulderr",						gp_shoulderr,
		"gp_shoulderrb",					gp_shoulderrb,
		"gp_select",						gp_select,
		"gp_start",							gp_start,
		"gp_stickl",						gp_stickl,
		"gp_stickr",						gp_stickr,
		"gp_padu",							gp_padu,
		"gp_padd",							gp_padd,
		"gp_padl",							gp_padl,
		"gp_padr",							gp_padr,
		"gp_axislh",						gp_axislh,
		"gp_axislv",						gp_axislv,
		"gp_axisrh",						gp_axisrh,
		"gp_axisrv",						gp_axisrv,
		"gp_axis_acceleration_x",			gp_axis_acceleration_x,
		"gp_axis_acceleration_y",			gp_axis_acceleration_y,
		"gp_axis_acceleration_z",			gp_axis_acceleration_z,
		"gp_axis_angular_velocity_x",		gp_axis_angular_velocity_x,
		"gp_axis_angular_velocity_y",		gp_axis_angular_velocity_y,
		"gp_axis_angular_velocity_z",		gp_axis_angular_velocity_z,
		"gp_axis_orientation_x",			gp_axis_orientation_x,
		"gp_axis_orientation_y",			gp_axis_orientation_y,
		"gp_axis_orientation_z",			gp_axis_orientation_z,
		"gp_axis_orientation_w",			gp_axis_orientation_w
	);
	
	#region New gamepad constants
	try {
		ffi.exposeConstant( 
			"gp_home",				gp_home,
			"gp_extra1",			gp_extra1,
			"gp_extra2",			gp_extra2,
			"gp_extra3",			gp_extra3,
			"gp_extra4",			gp_extra4,
			"gp_extra5",			gp_extra5,
			"gp_extra6",			gp_extra6,
			"gp_paddler",			gp_paddler,
			"gp_paddlel",			gp_paddlel,
			"gp_paddlerb",			gp_paddlerb,
			"gp_paddlelb",			gp_paddlelb,
			"gp_touchpadbutton",	gp_touchpadbutton
	
		);
	} catch(_) {
		__gmlspeak_log("New gamepad constants not available! Skipping...");		
	}
	#endregion
}