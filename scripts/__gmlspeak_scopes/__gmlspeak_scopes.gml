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


/// @return {Struct}
function gmlspeak_self() {
	static _scopes = __gmlspeak_scopes();
	return _scopes.self_;
}

/// @return {Struct}
function gmlspeak_other() {
	static _scopes = __gmlspeak_scopes();
	return _scopes.other_;
}