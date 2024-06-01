// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function __gmlspeak_method__(_scope, _func) {
	if (!__catspeak_is_withable(_scope)) {
		show_error("Scope cannot be " + string(_scope) + " in bind(). Must be a struct or instance!", true);	
	}

	if (is_gmlspeak(_func)) { 
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

function __GMLspeakMethodClass(_scope, _program, _global) constructor {
	scope = _scope;
	program = _program;
	global_ = _global;
	args = [];
};

function __GMLspeakMethodExec() {
	static scopes = __gmlspeak_scopes();
	var _result = undefined;
	var _args = args;
	
	var oldSelf = scopes.self_;
	var oldOther = scopes.other_ ?? global_;
	scopes.self_ = scope ?? global_;
	scopes.other_ = oldSelf ?? scopes.other_;
	scopes.other_ ??= global_;

	array_resize(args, argument_count);	
	
	for (var i = 0; i < argument_count; i++) {
		args[i] = argument[i];
	}
	
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
	
	//static scopes = __gmlspeak_scopes();
    //static args = array_create(argument_count);
	//// Everything in comments here is a shit implementation.
	//// So fuck that, Imma just disallow undefined
	//
	////args[0] = scope ?? selfScope;
	////args[0] ??= (variable_struct_exists(other, "shared") ? other.shared.globals : other);
	////selfScope = undefined;
	////args[0] = scope ?? (variable_struct_exists(other, "shared") ? other.shared.globals : other);
	//
	//// We're using weak references over here, since I'd rather them not keep shit alive
	//var _result = undefined;
	//var _args = args;
	//
	//if (array_length(args) < argument_count) {
	//	array_resize(args, argument_count);	
	//}
	//for (var i = 2; i < argument_count+2; i++) {
	//	args[i] = argument[i-2];
	//}
	//args[0] = scope;
	//args[1] = scopes.self_;
	//
	//try {
	//	var index = method_get_index(func);
	//	with(method_get_self(func)) {
	//		_result = script_execute_ext(index, _args, 0);	
	//	}
	//} finally {
	//	// Clearing args
	//	_i = 0;
	//	array_resize(args, 0);
	//}
	//
	//return _result;
}