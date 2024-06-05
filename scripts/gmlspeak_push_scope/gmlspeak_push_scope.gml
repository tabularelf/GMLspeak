// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function gmlspeak_push_scope(scopeTarget) {
	static _scopes = __gmlspeak_scopes();
	if (is_struct(scopeTarget) || (instance_exists(scopeTarget) && !object_exists(scopeTarget))) {
		ds_stack_push(_scopes.scopeStack, {
			self_: _scopes.self_,
			other_: _scopes.other_
		});
		
		_scopes.other_ = _scopes.self_;
		_scopes.self_ = scopeTarget;
		return true;
	} /*else if (object_exists(scopeTarget)) {
		var instancesCount = instance_number(scopeTarget);
		if (instancesCount == 0) {
			return false;	
		}
		var instances = array_create(instancesCount, noone);
		var i = 0;
		repeat(instancesCount) {
			instances[i] = instance_find(scopeTarget, i);
			++i;
		}
		return instances;
	}*/
}