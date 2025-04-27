/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_asset_types(ffi) {
	ffi.exposeConstant( 
		"asset_unknown", asset_unknown,
		"asset_sprite", asset_sprite,
		"asset_object", asset_object,
		"asset_script", asset_script,
		"asset_room", asset_room,
		"asset_path", asset_path,
		"asset_sound", asset_sound,
		"asset_tiles", asset_tiles,
		"asset_timeline", asset_timeline,
		"asset_font", asset_font,
		"asset_shader", asset_shader,
		"asset_sequence", asset_sequence,
		"asset_animationcurve", asset_animationcurve
	);
}