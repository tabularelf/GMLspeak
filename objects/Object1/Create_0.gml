// parse Catspeak code
var _t = get_timer();
catspeak = new CatspeakEnvironment();
show_debug_message((get_timer() - _t) / 1000);


var _str = @'
    show_debug_message("wololo")
    show_debug_message(Object1);
    instance_create_depth(32, 32, 0, obj_test);
';

var envTest = new GMLspeakEnvironment();
envTest.interface.exposeEverythingIDontCareIfModdersCanEditUsersSaveFilesJustLetMeDoThis = true;
var _program = envTest.compile(envTest.parseString(_str));
catspeak_execute(_program);

var _t = get_timer();
gmlspeak = new GMLspeakEnvironment();
gmlspeak.enableWritingRoom(true);
show_debug_message((get_timer() - _t) / 1000);

gmlspeak.interface.exposeFunction("string", string);
gmlspeak.interface.exposeFunction("real", real);
gmlspeak.interface.exposeFunction("get_timer", get_timer);
gmlspeak.interface.exposeFunction("show_debug_message", show_debug_message,
	"draw_self", 
	method(undefined, function() {
		draw_self();
	})
);
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
	variable_struct_remove,
    "event_inherited",
    event_inherited
);

gmlspeak.interface.exposeAsset("Room2");

Catspeak.interface.exposeFunction("event_inherited", event_inherited);
Catspeak.interface.exposeFunction("print", show_debug_message);

var _inst = instance_create_depth(0, 0, 0, obj_test2, {
   program: Catspeak.compileGML(Catspeak.parseString("event_inherited();")), 
});

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
factorial(6) // result: 720
';

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
catspeak_execute(programGMLspeak);
show_debug_message("GMLspeak factorial: " + string((get_timer() - _t) / 1000));

var _t = get_timer();
catspeak_execute(factorial, 1);
catspeak_execute(factorial, 2);
catspeak_execute(factorial, 3);
catspeak_execute(factorial, 4);
catspeak_execute(factorial, 5);
catspeak_execute(factorial, 6);
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

show_debug_message("Switch/case");
var _code = @'
testSwitch = function(result) {
	switch(result) {
		case 0: show_debug_message("AAA");
		case 1: show_debug_message("BBB");
		case 2: show_debug_message("Do I show?");
		case 3: return "switch/case: foo";
		case "Hi": show_debug_message("I am a string!"); break;
		default: return "hi";
	}
}
';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
catspeak_execute(program, self);
show_debug_message("Result: " + string(testSwitch(0)));
show_debug_message("Result: " + string(testSwitch(1)));
show_debug_message("Result: " + string(testSwitch(2)));
show_debug_message("Result: " + string(testSwitch(3)));
show_debug_message("Result: " + string(testSwitch(4)));
show_debug_message("Result: " + string(testSwitch("Hi")));

show_debug_message("For loop tests");

var _code = @'
var i = 0;
for(;;) {
	show_debug_message(i);
	i += 1;
	if (i > 9) {
		break;
	}
}

for(var i = 0; i < 9; i += 1) {
	show_debug_message(i);
}

';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
catspeak_execute(program);

//show_debug_message("Room switch test");
//var _code = @'
//show_debug_message(room);
//room = asset_get_index("Room2");';
//
//var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
//show_debug_message("Result: " + string(program(self)));

gmlspeak.interface.exposeFunction("irandom", irandom);
show_debug_message("Tenary operator test");
var _code = @'
var foo = irandom(3);
var bar = foo <= 1 ? true : "nice";
show_debug_message(bar);';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
repeat(10) {
	program();	
}

show_debug_message("Nullish assign test");
var _code = @'
var foo = undefined;
foo ??= true
return foo';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
show_debug_message("Result: " + string(program()));

var _code = @'
var foo = false;
foo ??= true
return foo';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
show_debug_message("Result: " + string(program()));

show_debug_message("Nullish test");
var _code = @'
var foo = undefined;
foo = foo ?? "bar";
return foo';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
show_debug_message("Result: " + string(program()));

var _code = @'
var foo = "foo";
foo = foo ?? "bar";
return foo';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
show_debug_message("Result: " + string(program()));

show_debug_message("Valid GML test");
var value = false;
value = value == false ? true && undefined : false;
show_debug_message(value);

var _code = @'
var value = false;
value = false == false ? true : false;
return value';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
show_debug_message("Result: " + string(program()));

rawr = "Hello world!";

show_debug_message("Struct validation test");
var _code = @'
var struct = {
	foo: "bar",
	bar: self.rawr
};

return struct[$ "foo"]';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
struct = catspeak_execute(program);
show_debug_message(json_stringify(struct));

//programKeyboard = gmlspeak.compileGML(gmlspeak.parseString(_code));

drawProgram = gmlspeak.compileGML(gmlspeak.parseString(@'
draw_self();
'));

show_debug_message("Self/Other test");
var _code = @'
with(other) {
	show_debug_message(foo);
}';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
gmlspeak.sharedGlobal.foo = "bar";
catspeak_execute_ext(program, self);
//show_debug_message(variable_struct_get_names(results[1]));
self.programGMLspeak = programGMLspeak;
gmlspeak.interface.exposeAsset("Room2");
randomize();

show_debug_message("Map/list accessor test");
gmlspeak.interface.exposeFunction("irandom", irandom);
gmlspeak.interface.exposeFunction("ds_map_create", ds_map_create);
gmlspeak.interface.exposeFunction("ds_list_create", ds_list_create);
gmlspeak.interface.exposeFunction("ds_grid_create", ds_grid_create);

var _code = @'
	global.map = ds_map_create();
	var key = "bar";
	global.map[? key] ??= 32;
	global.map[? key] *= 32;
	return global.map[? key];
';
var ast = gmlspeak.parseString(_code);
var program = gmlspeak.compileGML(ast);
show_debug_message(program());


// TODO::Works but also jank solution involved


var code = @'
	global.list = ds_list_create();
	var key = 4;
	global.list[| 4] = 128;
	global.list[| 4] *= 128;
	return global.list[| key];
';
var program = gmlspeak.compileGML(gmlspeak.parseString(code));
show_debug_message(program());

// Grid
var code = @'
	global.grid = ds_grid_create(8, 8);
	global.grid[# 2, 2] = 128;
	global.grid[# 2, 2] *= 128;
	return global.grid[# 2, 2];
';
var program = gmlspeak.compileGML(gmlspeak.parseString(code));
show_debug_message(program());

show_debug_message("Alarm test");
gmlspeak.enableWritingRoom(false);
var _code = @'
	alarm[0] = 4;
	alarm[0] *= 60;
';


var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
show_debug_message(catspeak_execute(program));
show_debug_message(alarm[0]);

var _code = @'
	global.grid[# 1, 1] = ds_map_create();
	global.grid[# 1, 1][? "bar"] = irandom(32);
	return room;
';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
show_debug_message(room_get_name(program()));


show_debug_message("_GMLINE_ test");
var _code = @'show_debug_message("This is on line " + string(_GMLINE_));
show_debug_message("This is on line " + string(_GMLINE_));
show_debug_message("This is on line " + string(_GMLINE_));
show_debug_message("This is on line " + string(_GMLINE_));
show_debug_message("This is on line " + string(_GMLINE_));
show_debug_message("This is on line " + string(_GMLINE_));
show_debug_message("This is on line " + string(_GMLINE_));
show_debug_message("This is on line " + string(_GMLINE_));
show_debug_message("This is on line " + string(_GMLINE_));
show_debug_message("This is on line " + string(_GMLINE_));
func = function() {
	show_debug_message("This is on line " + string(_GMLINE_) + " from " + string(_GMFUNCTION_) + " in " + string(_GMFILE_));
}
show_debug_message("This is from " + string(_GMFUNCTION_) + " in " + string(_GMFILE_));
show_debug_message("Is this a template string? {func}");

var foo = {
	alarm: [],
};
foo.alarm[0] = 16;
show_debug_message(foo.alarm[0]);
';
var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
program();

show_debug_message("Removed Catspeak function shortcut");
var _code = @'
	func = function {
		foo = "bar";
	}
';

try {
	var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
	program();	
	show_debug_message("Failure!");
} catch(_) {
	show_debug_message("OK!");	
}

gmlspeak.sharedGlobal.func();

show_debug_message("Room properties test");
var _code = @'
	room_persistent = true;
	return [room_width, room_height, room_persistent];
';

try {
	var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
	show_debug_message(program());	
} catch(_ex) {
	show_debug_message(_ex.message);	
}

gmlspeak.enableWritingRoomProperties(true);

var _code = @'
	room_persistent = true;
	return [room_width, room_height, room_persistent];
';

gmlspeak.enableWritingIOProperties(true);
gmlspeak.interface.exposeAsset("Sprite2");
var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
try {
	show_debug_message(program());	
} catch(_ex) {
	show_debug_message(_ex.message);	
}

show_debug_message("Argument test");
var _code = @'
	var num = 0;
	for(var i = 0; i < argument_count; i += 1) {
		num += argument[i];
	}
    
	view_visible[view_current] = false;
	cursor_sprite = Sprite2;
	return num;
';

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
show_debug_message(program(2, 2));

show_debug_message("delete test");
var _code = @'
    var foo = "bar";
    show_debug_message(foo);
    // delete foo;
    show_debug_message(foo);
    
    global.foo = {bar: {rawr: "32", rawr2: ds_map_create()}}
    global.foo.bar.rawr2[? "ree"] = 32;
    show_debug_message(global.foo);
    // delete global.foo.bar.rawr2[? "ree"];
    show_debug_message(global.foo);
    show_debug_message(global.foo.bar.rawr2[? "ree"]);
';
var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
program();
gmlspeak.interface.exposeFunction("buffer_create", buffer_create, "buffer_load", buffer_load, "buffer_exists", buffer_exists, "buffer_delete", buffer_delete, "buffer_write", buffer_read);

var _code = "try {var buff = buffer_load(\"123\"); return buffer_read(buff, buffer_u8);} catch(_ex) {show_debug_message(\"buffer doesn't exist!\"); return \"Happy birthday Sid!\"}";

var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
show_debug_message(program());

var program = gmlspeak.compileGML(gmlspeak.parseString("argument[0][2][? \"foo\"][$ \"bar\"].value"));
var array = [0, 0, ds_map_create()];
array[2][? "foo"] = {bar: {value: "Hi :3"}};

show_debug_message(program(array));


try {
    var env = new GMLspeakEnvironment();
    env.interface.compileFlags.checkForVariables = true;
    //env.interface.compileFlags.useVariableHash = true;
    var _code = @"
        rawr = 42;
        return foobar();
    ";
    var program = env.compileGML(env.parseString(_code));
    program();
} catch(_ex) {
    show_debug_message(_ex.message);   
}

var _code = "foo = \"bar\"; exit;";
var program = env.compileGML(env.parseString(_code));
program();


// EXPERIMENTAL
//gmlspeak.interface.compileFlags.pureFunctions = {
//    "string_lower": [is_string],
//    "string_upper": [is_string],
//    "real": function(v) {return !is_undefined(v)},
//};
//
//gmlspeak.interface.compileFlags.pureDynamicConstants = {
//    "os_type": true,
//};

gmlspeak.interface.exposeConstant("hello", "hello, world!");
gmlspeak.interface.exposeFunction("surface_create", surface_create, "surface_set_target", surface_set_target, "surface_reset_target", surface_reset_target, "surface_free", surface_free, "draw_text", draw_text);
var _code = @"
var surf = surface_create(128, 128);
surface_set_target(surf) {
    show_debug_message(1)
    draw_text(8, 8, hello);
    surface_reset_target();
    show_debug_message(2)
}
// surface_free(surf);
var i = 0; var j = 1; if (i == j) return 32; else return 34;";
var program = gmlspeak.compileGML(gmlspeak.parseString(_code));
show_debug_message(program());