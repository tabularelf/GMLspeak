// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function gmlspeak_pop_scope(){
	static _scopes = __gmlspeak_scopes();
	var _oldScope = ds_stack_pop(_scopes.scopeStack);
	
	_scopes.other_ = _oldScope.other_;
	_scopes.self_ = _oldScope.self_;
}