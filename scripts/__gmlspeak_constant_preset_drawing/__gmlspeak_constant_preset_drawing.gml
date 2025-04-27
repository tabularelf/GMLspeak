/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_drawing(ffi) {
	// Text allignment
	ffi.exposeConstant( 
		"fa_left", fa_left,
		"fa_right", fa_right,
		"fa_center", fa_center,
		"fa_top", fa_top,
		"fa_middle", fa_middle,
		"fa_bottom", fa_bottom
	);
	
	// Colours
	ffi.exposeConstant( 
		"c_aqua",		c_aqua,
		"c_black", 		c_black, 
		"c_blue", 		c_blue, 
		"c_dkgray",		c_dkgray,
		"c_fuchsia",	c_fuchsia,
		"c_gray", 		c_gray, 
		"c_green", 		c_green, 
		"c_lime", 		c_lime, 
		"c_ltgray",		c_ltgray,
		"c_maroon",		c_maroon,
		"c_navy", 		c_navy, 
		"c_olive" ,		c_olive,
		"c_orange",		c_orange,
		"c_purple",		c_purple,
		"c_red", 		c_red, 
		"c_silver",		c_silver,
		"c_teal",		c_teal,
		"c_white",		c_white,
		"c_yellow",		c_yellow
	);
	
	// Blendmodes
	ffi.exposeConstant( 
		"bm_normal", bm_normal,
		"bm_add", bm_add,
		"bm_max", bm_max,
		"bm_subtract", bm_subtract,
		"bm_zero", bm_zero,
		"bm_one", bm_one,
		"bm_src_color", bm_src_color,
		"bm_inv_src_color", bm_inv_src_color,
		"bm_src_colour", bm_src_colour,
		"bm_inv_src_colour", bm_inv_src_colour,
		"bm_src_alpha", bm_src_alpha,
		"bm_inv_src_alpha", bm_inv_src_alpha,
		"bm_dest_alpha", bm_dest_alpha,
		"bm_inv_dest_alpha", bm_inv_dest_alpha,
		"bm_dest_color", bm_dest_color,
		"bm_inv_dest_color", bm_inv_dest_color,
		"bm_dest_colour", bm_dest_colour,
		"bm_src_alpha_sat", bm_src_alpha_sat
	);
	
	// Lighting
	ffi.exposeConstant( 
		"lighttype_dir", lighttype_dir,
		"lighttype_point", lighttype_point
	);
	
	// Culling and depth testing
	ffi.exposeConstant( 
		"cmpfunc_never", cmpfunc_never,
		"cmpfunc_less", cmpfunc_less,
		"cmpfunc_equal", cmpfunc_equal,
		"cmpfunc_lessequal", cmpfunc_lessequal,
		"cmpfunc_greater", cmpfunc_greater,
		"cmpfunc_notequal", cmpfunc_notequal,
		"cmpfunc_greaterequal", cmpfunc_greaterequal,
		"cmpfunc_always", cmpfunc_always,
		"cull_noculling", cull_noculling,
		"cull_clockwise", cull_clockwise,
		"cull_counterclockwise", cull_counterclockwise
	);
	
	// Matrix
	ffi.exposeConstant( 
		"matrix_view", matrix_view,
		"matrix_projection", matrix_projection,
		"matrix_world", matrix_world
	);
	
	// Mipmap & Texture filtering
	ffi.exposeConstant( 
		"mip_markedonly", mip_markedonly,
		"mip_on", mip_on,
		"mip_off", mip_off,
		"tf_point", tf_point,
		"tf_anisotropic", tf_anisotropic,
		"tf_linear", tf_linear
	);
	
	// Texture Groups
	ffi.exposeConstant(
		"texturegroup_status_loaded", texturegroup_status_loaded,
		"texturegroup_status_loading", texturegroup_status_loading,
		"texturegroup_status_unloaded", texturegroup_status_unloaded,
		"texturegroup_status_fetched",	texturegroup_status_fetched
	);
	
	#region Text Asset
	try {
		ffi.exposeConstant( 
			"textalign_left", textalign_left,
			"textalign_right", textalign_right,
			"textalign_center", textalign_center,
			"textalign_justify", textalign_justify,
			"textalign_top", textalign_top,
			"textalign_bottom", textalign_bottom,
			"textalign_middle", textalign_middle
		);
	} catch(_) {
		__gmlspeak_log("Text Asset not available! Skipping...");	
	}
	#endregion
	
	#region Surface formats
	try {
	ffi.exposeConstant( 
		"surface_rgba8unorm",		surface_rgba8unorm,
		"surface_r8unorm",			surface_r8unorm,
		"surface_rg8unorm",			surface_rg8unorm,
		"surface_rgba4unorm",		surface_rgba4unorm,
		"surface_rgba16float",		surface_rgba16float,
		"surface_r16float",			surface_r16float,
		"surface_rgba32float",		surface_rgba32float,
		"surface_r32float",			surface_r32float
	);
	} catch(_) {
		__gmlspeak_log("Surface formats not available! Skipping...");	
	}
	#endregion
	
	#region Blendmodes Equations
	try {
		ffi.exposeConstant( 
			"bm_eq_add",				bm_eq_add,
			"bm_eq_subtract",			bm_eq_subtract,
			"bm_eq_max",				bm_eq_max,
			"bm_eq_min",				bm_eq_min,
			"bm_eq_reverse_subtract",	bm_eq_reverse_subtract
		);
	} catch(_) {
		__gmlspeak_log("Blendmode Equations not available! Skipping...");	
	}
	#endregion
	
	#region Stencil ops
	try {
		ffi.exposeConstant( 
			"stencilop_keep",			stencilop_keep,
			"stencilop_zero",			stencilop_zero,
			"stencilop_replace",		stencilop_replace,
			"stencilop_incr_wrap",		stencilop_incr_wrap,
			"stencilop_decr_wrap",		stencilop_decr_wrap,
			"stencilop_invert",			stencilop_invert,
			"stencilop_incr",			stencilop_incr,
			"stencilop_decr",			stencilop_decr
		);
	} catch(_) {
		__gmlspeak_log("Stencil Operations not available! Skipping...");	
	}
	#endregion
}