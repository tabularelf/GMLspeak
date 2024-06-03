// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function gmlspeak_method(_scope, _func) {
	if (is_real(_func)) || script_exists(_func) {
		return method(_scope, _func);	
	}
	
	if (is_method(_func)) {
		return __gmlspeak_method__(_scope, _func);
	}
}