#macro GMLspeak global.__gmlspeak__

function gmlspeak_force_init() {
	static _init = false;
	if (_init) return;
	_init = true;
	
	catspeak_force_init();
	__gmlspeak_presets_init();
	if (__GMLSPEAK_AUTO_INIT) {
		GMLspeak = new GMLspeakEnvironment();
	}
}
gmlspeak_force_init();