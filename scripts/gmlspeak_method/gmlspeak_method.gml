/// feather ignore all

/// @param {Struct, Id.Instance} struct_ref_or_instance
/// @param {Function} function_or_method
function gmlspeak_method(_scope, _func) {
	if ((is_real(_func)) || script_exists(_func)) && (!is_struct(_func)) {
		return method(_scope, _func);	
	}
	
	if (is_method(_func)) {
		return __gmlspeak_method__(_scope, _func);
	}
	
	show_error("Invalid function/method, got " + typeof(_func) + "!", true);
}