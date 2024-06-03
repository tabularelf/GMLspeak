// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function is_gmlspeak(value){
    if (is_method(value)) {
		var index = method_get_index(value);
		return (index == __gmlspeak_program__);
	}
	return false;
}