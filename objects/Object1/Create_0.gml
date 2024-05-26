// parse Catspeak code
gmlspeak = new GMLspeakEnvironment();
gmlspeak.interface.exposeFunction("string", string);
gmlspeak.interface.exposeFunction("real", real);
gmlspeak.interface.exposeFunction("get_timer", get_timer);
gmlspeak.interface.exposeFunction("show_debug_message", show_debug_message);

var ir = gmlspeak.parseString(@'
	var t = get_timer();
	repeat(10000) {
		var foo = 32;
	}
	
	return get_timer()-t;
');

var getMessage = gmlspeak.compileGML(ir);


var ir = gmlspeak.parseString(@'
	var t = get_timer();
	for(var i = 0; i < 10000; i += 1) {
		var foo = 32;
	}
	
	return get_timer()-t;
');

var getMessage2 = gmlspeak.compileGML(ir);
var time = getMessage() / 1000;
var time2 = getMessage2() / 1000;

show_debug_message("Repeat loop: " + string(time) + "ms");
show_debug_message("For loop: " + string(time2) + "ms");