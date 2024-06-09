/// feather ignore all
/// @ignore
function __gmlspeak_method__(_scope, _func) {
	if (!__catspeak_is_withable(_scope)) {
		show_error("Scope cannot be " + string(_scope) + " in bind(). Must be a struct or instance!", true);	
	}

	if (is_gmlspeak(_func) || is_catspeak(_func)) { 
		// Catspeak programs
		 return method(new __GMLspeakMethodClass(
			_scope,
			_func,
			method_get_self(_func)[$ "global_"] ?? undefined
		 ), __GMLspeakMethodExec);
	} else if (is_method(_func)) && (instanceof(method_get_self(_func)) == "__GMLspeakMethodClass") { 
		// Custom Binding Class for Catspeak Programs
		//var _newMethod = new __GMLspeakMethodClass(_scope, method_get_self(_func).func);
		return method(new __GMLspeakMethodClass(
			_scope,
			method_get_self(_func).program,
			method_get_self(_func)[$ "global_"] ?? undefined
		 ), __GMLspeakMethodExec);
		//return method({scope: _scope, program: method_get_index(_func), args: [], global_ : method_get_self(_func)[$ "global_"] ?? undefined}, __GMLspeakMethodExec);
	} else if (is_method(_func)) { 
		// Everything that's a method in general else that doesn't fall underneath the previous two.
		return method(_scope, _func);	
	} 
	
	show_error("Invalid function. Expected GMLspeakFunction/CatspeakFunction/Method.\nGot \"" + string(_func) + "\". With type \"" + typeof(_func) + "\".", true);
}

/// @ignore
function __GMLspeakMethodClass(_scope, _program, _global) constructor {
	scope = _scope;
	program = _program;
	global_ = _global;
	args = [];
};

function __GMLspeakMethodExec() {
	static scopes = __gmlspeak_scopes();
	var _result = undefined;
	
	var oldSelf = scopes.self_;
	var oldOther = scopes.other_ ?? global_;
	scopes.self_ = scope ?? global_;
	scopes.other_ = oldSelf ?? scopes.other_;
	scopes.other_ ??= global_;

	array_resize(args, argument_count);	
	
	for (var i = 0; i < argument_count; i++) {
		args[i] = argument[i];
	}
	
	var _args = args;
	var index_ = method_get_index(program);
	var callee_ = method_get_self(program);
	try {
		with(callee_) {
			_result = script_execute_ext(index_, _args);	
		}	
	} finally {
		array_resize(args, 0);
		scopes.self_ = oldSelf;
		scopes.other_ = oldOther;	
	}
	array_resize(args, 0);
	return _result;
}