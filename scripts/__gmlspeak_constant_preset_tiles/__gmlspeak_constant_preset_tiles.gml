/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_tiles(ffi) {
	ffi.exposeConstant( 
		"tile_rotate",		tile_rotate,
		"tile_mirror",		tile_mirror,
		"tile_flip",		tile_flip,
		"tile_index_mask",	tile_index_mask
	);
}