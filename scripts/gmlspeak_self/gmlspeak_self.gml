/// @return {Struct}
function gmlspeak_self() {
	static _scopes = __gmlspeak_scopes();
	return _scopes.self_;
}