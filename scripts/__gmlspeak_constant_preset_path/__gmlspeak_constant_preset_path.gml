/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_path(ffi) {
	ffi.exposeConstant(
		"path_action_stop", path_action_stop,
		"path_action_restart", path_action_restart,
		"path_action_continue", path_action_continue,
		"path_action_reverse", path_action_reverse
	);
}