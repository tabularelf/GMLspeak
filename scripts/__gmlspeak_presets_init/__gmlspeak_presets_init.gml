/// feather ignore all
enum GMLspeakConstantsPreset {
    /// Exposes safe type checking and type conversion functions.
    GENERAL = 100000,
	IO_ALL,
	IO_KEYBOARD,
	IO_MOUSE,
	IO_GAMEPAD,
	DYNAMIC_RESOURCES,
	DR_VIDEO,
	DR_VERTEX_BUFFERS,
	DR_BUFFERS,
	DR_DATA_STRUCTURES,
	DR_TIME_SOURCES,
	DR_SEQUENCES,
	DR_ASSET_TYPES,
	DR_SPRITES,
	DR_FLEX_PANELS,
	DR_PHYSICS,
	DR_PARTICLES,
	DR_PATHS,
	DR_AUDIO,
	DR_ROOM,
	DR_TILES,
	DR_NETWORKING,
	DRAWING,
	FILE_ATTRIBUTES,
	OS,
	EVENTS,
    /// @ignore
    __SIZE__,
}

/// @ignore
function __gmlspeak_presets_init() {
	static init = false;
	if (init) return;
	init = true;
	catspeak_preset_add(GMLspeakConstantsPreset.GENERAL, __gmlspeak_constant_preset_general);
	
	// IO
	catspeak_preset_add(GMLspeakConstantsPreset.IO_ALL, function(ffi) {
		__gmlspeak_constant_preset_io_keyboard(ffi);
		__gmlspeak_constant_preset_io_mouse(ffi);
		__gmlspeak_constant_preset_io_gamepad(ffi);
	});
	catspeak_preset_add(GMLspeakConstantsPreset.IO_KEYBOARD, __gmlspeak_constant_preset_io_keyboard);
	catspeak_preset_add(GMLspeakConstantsPreset.IO_MOUSE, __gmlspeak_constant_preset_io_mouse);
	catspeak_preset_add(GMLspeakConstantsPreset.IO_GAMEPAD, __gmlspeak_constant_preset_io_gamepad);
	
	// Dynamic resources
	catspeak_preset_add(GMLspeakConstantsPreset.DYNAMIC_RESOURCES, function(ffi) {
		__gmlspeak_constant_preset_vb(ffi);
		__gmlspeak_constant_preset_ds(ffi);
		__gmlspeak_constant_preset_buffers(ffi);
		__gmlspeak_constant_preset_networking(ffi);
		__gmlspeak_constant_preset_video(ffi);
		__gmlspeak_constant_preset_ps_pt(ffi);
		__gmlspeak_constant_preset_audio(ffi);
		__gmlspeak_constant_preset_ts(ffi);
		__gmlspeak_constant_preset_asset_types(ffi);
		__gmlspeak_constant_preset_flexpanels(ffi);
		__gmlspeak_constant_preset_sprites(ffi);
		__gmlspeak_constant_preset_room_layers(ffi);
		__gmlspeak_constant_preset_tiles(ffi);
		__gmlspeak_constant_preset_path(ffi);
		__gmlspeak_constant_preset_physics(ffi);
		__gmlspeak_constant_preset_sequences(ffi);
	});
	catspeak_preset_add(GMLspeakConstantsPreset.DR_ASSET_TYPES, __gmlspeak_constant_preset_asset_types);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_VIDEO, __gmlspeak_constant_preset_video);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_VERTEX_BUFFERS, __gmlspeak_constant_preset_vb);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_BUFFERS, __gmlspeak_constant_preset_buffers);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_NETWORKING, __gmlspeak_constant_preset_networking);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_DATA_STRUCTURES, __gmlspeak_constant_preset_ds);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_PARTICLES, __gmlspeak_constant_preset_ps_pt);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_FLEX_PANELS, __gmlspeak_constant_preset_flexpanels);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_PHYSICS, __gmlspeak_constant_preset_physics);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_SPRITES, __gmlspeak_constant_preset_sprites);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_TIME_SOURCES, __gmlspeak_constant_preset_ts);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_ROOM, __gmlspeak_constant_preset_room_layers);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_TILES, __gmlspeak_constant_preset_tiles);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_PATHS, __gmlspeak_constant_preset_path);
	catspeak_preset_add(GMLspeakConstantsPreset.DR_SEQUENCES, __gmlspeak_constant_preset_sequences);
	
	catspeak_preset_add(GMLspeakConstantsPreset.OS, __gmlspeak_constant_preset_os);
	catspeak_preset_add(GMLspeakConstantsPreset.FILE_ATTRIBUTES, __gmlspeak_constant_preset_fa);
	catspeak_preset_add(GMLspeakConstantsPreset.DRAWING, __gmlspeak_constant_preset_drawing);
	catspeak_preset_add(GMLspeakConstantsPreset.EVENTS, __gmlspeak_constant_preset_events);
}