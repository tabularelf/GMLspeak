/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_room_layers(ffi) {
	ffi.exposeConstant( 
		"layerelementtype_undefined", layerelementtype_undefined,
		"layerelementtype_background", layerelementtype_background,
		"layerelementtype_instance", layerelementtype_instance,
		"layerelementtype_oldtilemap", layerelementtype_oldtilemap,
		"layerelementtype_sprite", layerelementtype_sprite,
		"layerelementtype_tilemap", layerelementtype_tilemap,
		"layerelementtype_particlesystem", layerelementtype_particlesystem,
		"layerelementtype_tile", layerelementtype_tile,
		"layerelementtype_sequence", layerelementtype_sequence,
	);
	
	ffi.exposeDynamicConstant( 
		"room_first",		function() {return room_first;},
		"room_last",		function() {return room_last;},
		"view_current",		function() {return view_current;},
	);
	
	#region Non-LTS
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
			"layer_type_unknown", layer_type_unknown,
			"layer_type_room", layer_type_room,
			"layer_type_ui_display", layer_type_ui_display,
			"layer_type_ui_viewports", layer_type_ui_viewports
		);
	} catch(_) {
		__gmlspeak_log("Layer Types not available! Skipping...");	
	}
	#endregion
}