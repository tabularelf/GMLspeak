// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function __gmlspeak_scopes() {
	static _scopes = {
		self_: undefined,
		other_: undefined,
		global_: undefined,
		scopeStack: ds_stack_create(),
	};
	
	return _scopes;
}