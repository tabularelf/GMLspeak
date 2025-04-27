/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_ps_pt(ffi) {
	ffi.exposeConstant(
		"pt_shape_circle", pt_shape_circle, 
		"pt_shape_cloud", pt_shape_cloud, 
		"pt_shape_disk", pt_shape_disk, 
		"pt_shape_explosion", pt_shape_explosion, 
		"pt_shape_flare", pt_shape_flare, 
		"pt_shape_line", pt_shape_line, 
		"pt_shape_pixel", pt_shape_pixel, 
		"pt_shape_ring", pt_shape_ring, 
		"pt_shape_smoke", pt_shape_smoke, 
		"pt_shape_snow", pt_shape_snow, 
		"pt_shape_spark", pt_shape_spark, 
		"pt_shape_square", pt_shape_square, 
		"pt_shape_star", pt_shape_star,
		"pt_shape_sphere", pt_shape_sphere
	);
	
	ffi.exposeConstant(
		"ps_distr_linear", ps_distr_linear,
		"ps_distr_gaussian", ps_distr_gaussian,
		"ps_distr_invgaussian", ps_distr_invgaussian,
		"ps_shape_rectangle", ps_shape_rectangle,
		"ps_shape_ellipse", ps_shape_ellipse,
		"ps_shape_diamond", ps_shape_diamond,
		"ps_shape_line", ps_shape_line
	);
	
	ffi.exposeConstant( 
		"ef_cloud",		ef_cloud, 
		"ef_ellipse",	ef_ellipse,
		"ef_explosion",	ef_explosion,
		"ef_firework", 	ef_firework, 
		"ef_flare",		ef_flare,
		"ef_rain",		ef_rain,
		"ef_ring",		ef_ring,
		"ef_smoke",		ef_smoke,
		"ef_smokeup",	ef_smokeup,
		"ef_snow",		ef_snow,
		"ef_spark",		ef_spark,
		"ef_star",		ef_star,		
	);
	
	try {
		ffi.exposeConstant( 
			"asset_particlesystem", asset_particlesystem,
			"layerelementtype_particlesystem", layerelementtype_particlesystem
		);
	} catch(_) {
		__gmlspeak_log("Particle System Asset not available! Skipping...");	
	}
	
	try {
		ffi.exposeConstant(
			"layerelementtype_text", layerelementtype_text
		);
	} catch(_) {
		__gmlspeak_log("Text Asset not available! Skipping...");	
	}
}