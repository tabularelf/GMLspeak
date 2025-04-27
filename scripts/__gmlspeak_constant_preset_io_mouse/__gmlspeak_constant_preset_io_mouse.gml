/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_io_mouse(ffi) {
	ffi.exposeDynamicConstant(
		"mouse_button", function() {return mouse_button;},
		"mouse_lastbutton", function() {return mouse_lastbutton;},
		"mouse_x", function() {return mouse_x;},
		"mouse_y", function() {return mouse_y;},
	);
		
	ffi.exposeConstant( 
		"mb_left",		mb_left,
		"mb_right",		mb_right,
		"mb_any",		mb_any,
		"mb_middle",	mb_middle,
		"mb_side1",		mb_side1,
		"mb_side2",		mb_side2,
		"mb_none",		mb_none
	);
	
	ffi.exposeConstant( 
		"cr_none",			cr_none,			
		"cr_default",		cr_default,
		"cr_arrow",			cr_arrow,
		"cr_cross",			cr_cross,
		"cr_beam",			cr_beam,
		"cr_size_nesw",		cr_size_nesw,
		"cr_size_ns",		cr_size_ns,
		"cr_size_nwse",		cr_size_nwse,
		"cr_size_we",		cr_size_we,
		"cr_uparrow",		cr_uparrow,
		"cr_hourglass",		cr_hourglass,
		"cr_drag",			cr_drag,
		"cr_appstart" ,		cr_appstart,
		"cr_handpoint",		cr_handpoint,
		"cr_size_all", 		cr_size_all,
	);
}