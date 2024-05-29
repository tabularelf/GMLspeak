// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function __gmlspeak_method__(_scope, _func) {
	if (!__catspeak_is_withable(_scope)) {
		show_error("Scope cannot be " + string(_scope) + " in bind(). Must be a struct or instance!", true);	
	}

	if (is_gmlspeak(_func)) { 
		// Catspeak programs
		var _newMethod = new __GMLspeakMethodClass(_scope, method_get_index(_func) == __catspeak_function__ ? 
			method({program: _func, args: [], global_ : method_get_self(_func)[$ "global_"] ?? undefined}, __gmlspeak_program__) : _func
		);
		 return method(_newMethod, __GMLspeakMethodExec);
	} else if (is_method(_func)) && (instanceof(method_get_self(_func)) == "__GMLspeakMethodClass") { 
		// Custom Binding Class for Catspeak Programs
		var _newMethod = new __GMLspeakMethodClass(_scope, method_get_self(_func).func);
		return method(_newMethod, __GMLspeakMethodExec);
	} else if (is_method(_func)) { 
		// Everything that's a method in general else that doesn't fall underneath the previous two.
		return method(new __GMLspeakMethodClass(_scope, _func), __GMLspeakMethodExec);	
	} 
	
	show_error("Invalid function. Expected GMLspeakFunction/CatspeakFunction/Method.\nGot \"" + string(_func) + "\". With type \"" + typeof(_func) + "\".", true);
}

function __GMLspeakMethodClass(_scope, _func) constructor {
	scope = _scope;
	func = _func;
};

function __GMLspeakMethodExec() {
	static scopes = __gmlspeak_scopes();
    static args = array_create(argument_count);
	// Everything in comments here is a shit implementation.
	// So fuck that, Imma just disallow undefined
	
	//args[0] = scope ?? selfScope;
	//args[0] ??= (variable_struct_exists(other, "shared") ? other.shared.globals : other);
	//selfScope = undefined;
	//args[0] = scope ?? (variable_struct_exists(other, "shared") ? other.shared.globals : other);
	
	// We're using weak references over here, since I'd rather them not keep shit alive
	var _result = undefined;
	var _args = args;
	
	if (array_length(args) < argument_count) {
		array_resize(args, argument_count);	
	}
	for (var i = 2; i < argument_count+2; i++) {
		args[i] = argument[i-2];
	}
	args[0] = scope;
	args[1] = scopes.self_;
	
	try {
		var index = method_get_index(func);
		with(method_get_self(func)) {
			_result = script_execute_ext(index, _args, 0);	
		}
	} finally {
		// Clearing args
		_i = 0;
		array_resize(args, 0);
	}
	
	return _result;
}