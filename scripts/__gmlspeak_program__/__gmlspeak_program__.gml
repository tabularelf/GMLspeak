/// feather ignore all
/// @ignore
function __gmlspeak_program__(self_, other_ = undefined) {
	static scopes = __gmlspeak_scopes();
	var oldSelf = scopes.self_;
	var oldOther = scopes.other_ ?? global_;
	scopes.self_ = self_ ?? global_;
	scopes.other_ = other_ ?? scopes.other_;
	scopes.other_ ??= global_;
	
	// Get arguments
	var i = 2;
	repeat(argument_count-2) {
		args[i-2] = argument[i];
		i++;
	}
	
	var args_ = args;
	var index_ = method_get_index(program);
	var callee_ = method_get_self(program);
	try {
		with(callee_) {
			var result = script_execute_ext(index_, args_);	
		}	
	} finally {
		array_resize(args, 0);
		scopes.self_ = oldSelf;
		scopes.other_ = oldOther;	
	}
	
	// Clear arguments
	return result;
}