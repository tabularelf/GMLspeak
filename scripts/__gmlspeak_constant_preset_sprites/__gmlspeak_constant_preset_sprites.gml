/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_sprites(ffi) {
	ffi.exposeConstant( 
		"nineslice_left",       nineslice_left,
		"nineslice_top", 		nineslice_top, 
		"nineslice_right",		nineslice_right,
		"nineslice_bottom", 	nineslice_bottom, 
		"nineslice_centre", 	nineslice_centre, 
		"nineslice_stretch",	nineslice_stretch,
		"nineslice_repeat", 	nineslice_repeat, 
		"nineslice_blank",		nineslice_blank,
		"nineslice_mirror",		nineslice_mirror,
		"nineslice_hide",		nineslice_hide,
		"nineslice_center",		nineslice_center
	
	);

	ffi.exposeConstant(
		"bboxmode_automatic",	bboxmode_automatic,
		"bboxmode_fullimage",	bboxmode_fullimage,
		"bboxmode_manual",		bboxmode_manual,
		"bboxkind_rectangular",	bboxkind_rectangular,
		"bboxkind_ellipse",		bboxkind_ellipse,
		"bboxkind_diamond",		bboxkind_diamond,
		"bboxkind_precise",		bboxkind_precise
	);
	
	ffi.exposeConstant(
		"spritespeed_framespersecond",		spritespeed_framespersecond,
		"spritespeed_framespergameframe",	spritespeed_framespergameframe,
	);
	
	
	// Non-LTS
	try {
		ffi.exposeConstant( 
			"sprite_add_ext_error_unknown",				sprite_add_ext_error_unknown,
			"sprite_add_ext_error_cancelled",			sprite_add_ext_error_cancelled,
			"sprite_add_ext_error_spritenotfound",		sprite_add_ext_error_spritenotfound,
			"sprite_add_ext_error_loadfailed",			sprite_add_ext_error_loadfailed,
			"sprite_add_ext_error_decompressfailed",	sprite_add_ext_error_decompressfailed,
			"sprite_add_ext_error_setupfailed",			sprite_add_ext_error_setupfailed
		);
	} catch(_) {
		__gmlspeak_log("sprite_add_ext not available! Skipping...");	
	}
}