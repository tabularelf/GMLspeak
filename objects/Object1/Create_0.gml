// parse Catspeak code
gmlspeak = new GMLspeakEnvironment();
gmlspeak.interface.exposeFunction("string", string);
gmlspeak.interface.exposeFunction("real", real);
gmlspeak.interface.exposeFunction("get_timer", get_timer);
gmlspeak.interface.exposeFunction("show_debug_message", show_debug_message);
gmlspeak.interface.exposeFunction("variable_struct_get", variable_struct_get, "variable_struct_set", variable_struct_set);
gmlspeak.interface.exposeFunction("variable_struct_get_names", variable_struct_get_names);

var ir = gmlspeak.parseString(@'
	foo = "bar";
	printMe = method(id, function(str) {
		show_debug_message(string(str) + " " + string(self));
	});
	show_debug_message(variable_struct_get_names(id));
');

var program = gmlspeak.compileGML(ir);
program(id);
printMe("Hello world from");








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