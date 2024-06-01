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
gmlspeak.interface.exposeFunction("show_debug_message", show_debug_message);
catspeak.interface.exposeFunction("string", string);
catspeak.interface.exposeFunction("show_debug_message", show_debug_message);
gmlspeak.interface.exposeFunction(
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
var _struct = {};
_struct.factorial = __gmlspeak_method__(_struct, factorial);
_struct.factorial(1);
_struct.factorial(2);
_struct.factorial(3);
_struct.factorial(4);
_struct.factorial(5);
_struct.factorial(6);
show_debug_message("GMLspeak Manual factorial2: " + string((get_timer() - _t) / 1000));

var _t = get_timer();
nativeFunc();
show_debug_message("Native factorial: " + string((get_timer() - _t) / 1000));	