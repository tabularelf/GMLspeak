// parse Catspeak code
var _t = get_timer();
catspeak = new CatspeakEnvironment();
show_debug_message((get_timer() - _t) / 1000);

var _t = get_timer();
gmlspeak = new GMLspeakEnvironment();
show_debug_message((get_timer() - _t) / 1000);

gmlspeak.interface.exposeFunction("string", string);
gmlspeak.interface.exposeFunction("real", real);
gmlspeak.interface.exposeFunction("get_timer", get_timer);
gmlspeak.interface.exposeFunction("show_debug_message", show_debug_message,
	"draw_self", 
	function() {
		with(gmlspeak_self()) return draw_self();
	});
catspeak.interface.exposeFunction("string", string);
catspeak.interface.exposeFunction("show_debug_message", show_debug_message);
gmlspeak.interface.exposeFunction(
	"asset_get_index", asset_get_index,
	"variable_struct_get_names", 
	variable_struct_get_names, 
	"struct_get_names", 
	variable_struct_get_names,
	"variable_struct_names_count",
	variable_struct_names_count,
	"struct_names_count"
	,variable_struct_names_count,
	"variable_struct_get", 
	variable_struct_get, 
	"variable_struct_set", 
	variable_struct_set, 
	"struct_get", 
	variable_struct_get, 
	"struct_set", 
	variable_struct_set,
	"variable_struct_exists",
	variable_struct_exists,
	"struct_exists",
	variable_struct_exists,
	"variable_struct_remove",
	variable_struct_remove,
	"struct_remove",
	variable_struct_remove
);

Catspeak.interface.exposeFunction("print", show_debug_message);

codeCatspeak = @'
-- compute the factorial of n
factorial = fun (n) {
  if (n <= 1) {
    return 1;
  }
  return n * factorial(n - 1)
}

factorial(1) -- result: 1
factorial(2) -- result: 2
factorial(3) -- result: 6
factorial(4) -- result: 24
factorial(5) -- result: 120
factorial(6) -- result: 720';

nativeFunc = function () {
    factorial = function (n) {
        if (n <= 1) {
            return 1;
        }
        return n * factorial(n - 1);
    };

    factorial(1);
    factorial(2);
    factorial(3);
    factorial(4);
    factorial(5);
    factorial(6);
};


code = @'
// compute the factorial of n
factorial = function (n) {
  if (n <= 1) {
    return 1;
  }
  return n * factorial(n - 1)
}

factorial(1) // result: 1
factorial(2) // result: 2
factorial(3) // result: 6
factorial(4) // result: 24
factorial(5) // result: 120
factorial(6) // result: 720';

var programGMLspeak = gmlspeak.compileGML(gmlspeak.parseString(code));
var programCatspeak = Catspeak.compileGML(Catspeak.parseString(codeCatspeak));

show_debug_message("Normal");
var _t = get_timer();
programCatspeak();
show_debug_message("Catspeak factorial: " + string((get_timer() - _t) / 1000));
var globals = programCatspeak.getGlobals();
var _t = get_timer();
globals.factorial(1);
globals.factorial(2);
globals.factorial(3);
globals.factorial(4);
globals.factorial(5);
globals.factorial(6);
show_debug_message("Catspeak Manual factorial: " + string((get_timer() - _t) / 1000));
var _t = get_timer();
programGMLspeak(id);
show_debug_message("GMLspeak factorial: " + string((get_timer() - _t) / 1000));

var _t = get_timer();
factorial(1);
factorial(2);
factorial(3);
factorial(4);
factorial(5);
factorial(6);
show_debug_message("GMLspeak Manual factorial: " + string((get_timer() - _t) / 1000));

var _t = get_timer();
nativeFunc();
show_debug_message("Native factorial: " + string((get_timer() - _t) / 1000));	


show_debug_message("Do/Until Test");
var _code = @'
var num = 0;
do {
	num += 1;
	
} until (num > 9999) 

show_debug_message("Number GMLspeak result: " + string(num));
';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
var _t = get_timer();
program(self);
show_debug_message("do/until GMLspeak: " + string((get_timer() - _t) / 1000));	

var _t = get_timer();
var num = 0;
do {
	num += 1;
} until(num > 9999) 

show_debug_message("Number normal: result: " + string(num));
show_debug_message("do/until Normal: " + string((get_timer() - _t) / 1000));	

//show_debug_message("Switch/case");
//var _code = @'
//switch(2) {
//	case 0: return 1;
//	case 1: return 2;
//	case 2: return 3;
//}
//';
//
//var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
//show_debug_message("Result: " + string(program(self)));

show_debug_message("Room switch test");
var _code = @'
show_debug_message(room);
room = asset_get_index("Room2");';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
show_debug_message("Result: " + string(program(self)));

drawProgram = gmlspeak.compileGML(gmlspeak.parseString(@'
draw_self();
'));