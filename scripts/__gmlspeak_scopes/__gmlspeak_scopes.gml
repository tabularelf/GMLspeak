/// @return {Struct}
function __gmlspeak_scopes() {
	static _scopes = {
		self_: undefined,
		other_: undefined,
		global_: undefined,
		scopeStack: ds_stack_create(),
	};
	
	return _scopes;
}