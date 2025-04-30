/// @feather ignore all
function GMLspeakEnvironment(addAllConstants = true) : CatspeakEnvironment() constructor {
	self.parserType = GMLspeakParser;
	self.lexerType = GMLspeakLexer;
    self.codegenType = GMLspeakCodegen;
	self.currentFilename = "unknown";
	self.canWriteRoomProperties = false;
	enableSharedGlobal(true);
    interface.compileFlags = {
        checkForVariables: true,
        useVariableHash: false,
		useGM8UndefinedVariableBehaviourThisIsReallyBadAndAwfulYouWillComeAcrossSoManyErrorsAndYouCommitTheUltimateGameMakerSin_YouWillMeetGod_AndThePopeHimselfWillSmiteYouDown: false,
		GM8UndefinedVariableValue: undefined,
    };
	
	if (addAllConstants) {
		applyPreset(GMLspeakConstantsPreset.GENERAL);
		applyPreset(GMLspeakConstantsPreset.IO_ALL);
		applyPreset(GMLspeakConstantsPreset.DYNAMIC_RESOURCES);
		applyPreset(GMLspeakConstantsPreset.DRAWING);
		applyPreset(GMLspeakConstantsPreset.FILE_ATTRIBUTES);
		applyPreset(GMLspeakConstantsPreset.EVENTS);
		applyPreset(GMLspeakConstantsPreset.OS);
	}

	static enableWritingRoom = function(_value) {
		if (_value) {
			addKeyword( 
				"room",				GMLspeakToken.ROOM,
			);
			
			interface.addBanList("room");
		} else {
			removeKeyword(
				"room"
			);
			
			interface.addPardonList("room");
		}
		
		return self;
	}
	
	static enableWritingRoomProperties = function(_value) {
		if (_value) {
			addKeyword( 
				"room_width",				GMLspeakToken.ROOM_WIDTH,
				"room_height",				GMLspeakToken.ROOM_HEIGHT,
				"room_persistent",			GMLspeakToken.ROOM_PERSISTENT,
			);
			
			interface.addBanList("room_width", "room_height", "room_persistent");
		} else {
			removeKeyword(
				"room_width",	
				"room_height",	
				"room_persistent",
			);
			interface.addPardonList(
				"room_width", 
				"room_height", 
				"room_persistent"
			);
		}
		
		canWriteRoomProperties = _value;
		
		return self;
	}
	
	static enableWritingIOProperties = function(_value) {
		if (_value) {
			addKeyword( 
				"keyboard_string",		GMLspeakToken.KEYBOARD_STRING,
				"keyboard_key",			GMLspeakToken.KEYBOARD_KEY,
				"keyboard_lastchar",	GMLspeakToken.KEYBOARD_LASTCHAR,
				"keyboard_lastkey",		GMLspeakToken.KEYBOARD_LASTKEY,
				"mouse_lastbutton",		GMLspeakToken.MOUSE_LASTBUTTON,
				"cursor_sprite",		GMLspeakToken.CURSOR_SPRITE,
			);
			
			interface.addBanList(
				"keyboard_string",
				"keyboard_key",
				"keyboard_lastchar",
				"keyboard_lastkey",
				"mouse_lastbutton",
				"cursor_sprite",
			);
		} else {
			removeKeyword(
				"keyboard_string",
				"keyboard_key",
				"keyboard_lastchar",
				"keyboard_lastkey",
				"mouse_lastbutton",
				"cursor_sprite",
			);
			
			interface.addPardonList(
				"keyboard_string",
				"keyboard_key",
				"keyboard_lastchar",
				"keyboard_lastkey",
				"mouse_lastbutton",
				"cursor_sprite",
			);
		}
		
		return self;
	}

	static assignFilename = function(_value) {
		if (!is_string(_value)) && (!is_undefined(_value)) {
			_value = string(_value);	
		}
		currentFilename = _value ?? "unknown";
		return self;
	}
	
	#region Keywords
	renameKeyword(
        "let", "var",
        "fun", "function",
    );
	
	removeKeyword(
		"|>",
		"<|",
		"params",
	); 
	
	addKeyword(
	
		// HOTFIX::Must replace with a better lexer later.
		";",				CatspeakToken.SEMICOLON,
		":",				CatspeakToken.COLON,
		"//",				CatspeakToken.COMMENT,
		";",				CatspeakToken.SEMICOLON,
		":",				CatspeakToken.COLON,
		",",				CatspeakToken.COMMA,
		".",				CatspeakToken.DOT,
		"=",				CatspeakToken.ASSIGN,
		"*=",				CatspeakToken.ASSIGN_MULTIPLY,
		"/=",				CatspeakToken.ASSIGN_DIVIDE,
		"-=",				CatspeakToken.ASSIGN_SUBTRACT,
		"+=",				CatspeakToken.ASSIGN_PLUS,
		"%",				CatspeakToken.REMAINDER,
		"*",				CatspeakToken.MULTIPLY,
		"/",				CatspeakToken.DIVIDE,
		"div",				CatspeakToken.DIVIDE_INT,
		"-",				CatspeakToken.SUBTRACT,
		"+",				CatspeakToken.PLUS,
		"==",				CatspeakToken.EQUAL,
		"!=",				CatspeakToken.NOT_EQUAL,
		">",				CatspeakToken.GREATER,
		">=",				CatspeakToken.GREATER_EQUAL,
		"<",				CatspeakToken.LESS,
		"<=",				CatspeakToken.LESS_EQUAL,
		"!",				CatspeakToken.NOT,
		"~",				CatspeakToken.BITWISE_NOT,
		">>",				CatspeakToken.SHIFT_RIGHT,
		"<<",				CatspeakToken.SHIFT_LEFT,
		"&",				CatspeakToken.BITWISE_AND,
		"^",				CatspeakToken.BITWISE_XOR,
		"|",				CatspeakToken.BITWISE_OR,
		"self",				CatspeakToken.SELF,
        "other",			CatspeakToken.OTHER,
        "try",              CatspeakToken.DO,
        "catch",            CatspeakToken.CATCH,
        "finally",          GMLspeakToken.FINALLY,
        "toString",         CatspeakToken.IDENT,
		
		// Implemented as comments since these kind of act like two separate comments.
		// What could go wrong? 
		"#region",			CatspeakToken.COMMENT,
		"#endregion",		CatspeakToken.COMMENT,
		"div",				CatspeakToken.DIVIDE_INT,
	    "&&",				CatspeakToken.AND,
	    "||",				CatspeakToken.OR,
		":=",				CatspeakToken.ASSIGN,
	    "mod",				CatspeakToken.REMAINDER,
	    "not",				CatspeakToken.NOT,
		"<>",				CatspeakToken.NOT_EQUAL,
		"begin",			CatspeakToken.BRACE_LEFT,
		"then",				CatspeakToken.WHITESPACE,
		"for",				GMLspeakToken.FOR,
		"do",				GMLspeakToken.DO,
		"until",			GMLspeakToken.UNTIL,
		//"static", GMLspeakToken.WHITESPACE, // TODO, apply some other logic
		"end",				CatspeakToken.BRACE_RIGHT,
		"repeat",			GMLspeakToken.REPEAT,
		"switch",			GMLspeakToken.SWITCH,
		"case",				GMLspeakToken.CASE,
		"default",			GMLspeakToken.DEFAULT,
		"/*",				GMLspeakToken.COMMENT_LONG,
		"*/",				GMLspeakToken.COMMENT_LONG_END,
		"??",				GMLspeakToken.NULLISH,
		"??=",				GMLspeakToken.NULLISH_ASSIGN,
		"?",				GMLspeakToken.QUESTION_MARK_SIGN,
		"@",				GMLspeakToken.AT_SIGN,
		"$",				GMLspeakToken.DOLLAR_SIGN,
		"|",				GMLspeakToken.VERTICAL_BAR,
		"_GMLINE_",			GMLspeakToken.__GMLINE__,
		"_GMFILE_",			GMLspeakToken.__GMFILE__,
		"_GMFUNCTION_",		GMLspeakToken.__GMFUNCTION__,
		"argument",			CatspeakToken.PARAMS,
		"argument0",		CatspeakToken.PARAMS,
		"argument1",		CatspeakToken.PARAMS,
		"argument2",		CatspeakToken.PARAMS,
		"argument3",		CatspeakToken.PARAMS,
		"argument4",		CatspeakToken.PARAMS,
		"argument5",		CatspeakToken.PARAMS,
		"argument6",		CatspeakToken.PARAMS,
		"argument7",		CatspeakToken.PARAMS,
		"argument8",		CatspeakToken.PARAMS,
		"argument9",		CatspeakToken.PARAMS,
		"argument10",		CatspeakToken.PARAMS,
		"argument11",		CatspeakToken.PARAMS,
		"argument12",		CatspeakToken.PARAMS,
		"argument13",		CatspeakToken.PARAMS,
		"argument14",		CatspeakToken.PARAMS,
		"argument15",		CatspeakToken.PARAMS,
		"argument_count",	CatspeakToken.PARAMS_COUNT,
		"exit",				GMLspeakToken.EXIT,
		// TODO: Make delete work with other accessors
		//"delete",           GMLspeakToken.DELETE,
	);
	
	interface.exposeDynamicConstant(
		// Exists as getters only
		"room", 
		function() {return room;},
		"room_width", 
		function() {return room_width;},
		"room_height", 
		function() {return room_height;},
		"room_persistent", 
		function() {return room_persistent;},
		"keyboard_string", 
		function() {return keyboard_string;},
	);
	
	interface.exposeDynamicConstant("global", function() {return sharedGlobal;});
	
	interface.exposeMethod( 
		"method",
		__gmlspeak_method__,
		"$$__BIND__$$",
		function(_scope, _func) {
			if (_scope == sharedGlobal) || (_scope == global) {
				return _func;	
			}
			
			return catspeak_method(_scope, _func);
		},
		"$$__IS_NOT_NULLISH__$$", 
		function(value) {
			return (value != undefined) && (value != pointer_null);	
		},
		"$$__OPTIONAL_ARGUMENT_SKIPPED__$$",
		function(value) {
			return !is_undefined(value);	
		},
		"$$__CURSOR_SPRITE__$$", 
		function() {
			if (argument_count == 0) {
				return cursor_sprite;	
			}
			
			cursor_sprite = argument[0];
		},
		"$$__MOUSE_LASTBUTTON__$$",
		function() {
			if (argument_count == 0) {
				return mouse_lastbutton;	
			}
			
			mouse_lastbutton = argument[0];
		},
		"$$__KEYBOARD_STRING__$$", 
		function() {
			if (argument_count == 0) {
				return keyboard_string;
			}
			
			keyboard_string = argument[0];
		},
		"$$__KEYBOARD_KEY__$$", 
		function() {
			if (argument_count == 0) {
				return keyboard_key;
			}
			
			keyboard_key = argument[0];
		},
		"$$__KEYBOARD_LASTCHAR__$$", 
		function() {
			if (argument_count == 0) {
				return keyboard_lastchar;
			}
			
			keyboard_lastchar = argument[0];
		},
		"$$__KEYBOARD_LASTKEY__$$", 
		function() {
			if (argument_count == 0) {
				return keyboard_lastkey;
			}
			
			keyboard_lastkey = argument[0];
		},
		"$$__ROOM__$$", 
		function() {
			if (argument_count == 0) {
				return room;	
			}
			
			room = argument[0];
		},
		"$$__ROOM_WIDTH__$$", 
		function() {
			if (argument_count == 0) {
				return room_width;	
			}
			
			room_width = argument[0];
		},
		"$$__ROOM_HEIGHT__$$", 
		function() {
			if (argument_count == 0) {
				return room_height;	
			}
			
			room_height = argument[0];
		},
		"$$__ROOM_PERSISTENT__$$", 
		function() {
			if (argument_count == 0) {
				return room_persistent;	
			}
			
			room_persistent = argument[0];
		},
		"$$__VIEW_ENABLED__$$", 
		function() {
			if (argument_count == 0) {
				return view_enabled;	
			}
			
			view_enabled = argument[0];
		},
		"$$__VIEW_VISIBLE__$$",
		function(key) {
			if (argument_count == 1) {
				return view_visible[key];	
			}
			
			if (!canWriteRoomProperties) return __gmlspeak_error("Writing to room properties is disabled!");
			view_visible[key] = argument[1];	
		},
		"$$__VIEW_CAMERA__$",
		function(key) {
			if (argument_count == 1) {
				return view_camera[key];	
			}
			
			if (!canWriteRoomProperties) return __gmlspeak_error("Writing to room properties is disabled!");
			view_camera[key] = argument[1];	
		},
		"$$__VIEW_XPORT__$$",
		function(key) {
			if (argument_count == 1) {
				return view_xport[key];	
			}
			
			if (!canWriteRoomProperties) return __gmlspeak_error("Writing to room properties is disabled!");
			view_xport[key] = argument[1];	
		},
		"$$__VIEW_YPORT__$$",
		function(key) {
			if (argument_count == 1) {
				return view_xport[key];	
			}
			
			if (!canWriteRoomProperties) return __gmlspeak_error("Writing to room properties is disabled!");
			view_xport[key] = argument[1];	
		},
		"$$__VIEW_WPORT__$$",
		function(key) {
			if (argument_count == 1) {
				return view_wport[key];	
			}
			
			if (!canWriteRoomProperties) return __gmlspeak_error("Writing to room properties is disabled!");
			view_wport[key] = argument[1];	
		},
		"$$__VIEW_HPORT__$$",
		function(key) {
			if (argument_count == 1) {
				return view_hport[key];	
			}
			
			if (!canWriteRoomProperties) return __gmlspeak_error("Writing to room properties is disabled!");
			view_hport[key] = argument[1];	
		},
		"$$__VIEW_SURFACE_ID__$$",
		function(key) {
			if (argument_count == 1) {
				return view_surface_id[key];	
			}
			
			if (!canWriteRoomProperties) return __gmlspeak_error("Writing to room properties is disabled!");
			view_surface_id[key] = argument[1];	
		},
        "$$__STRUCT_ACCESSOR__$$",
		function(collection, key) {
			if (argument_count == 2) {
				return collection[$ key];	
			}
			
			collection[$ key] = argument[2];
		},
		"$$__MAP_ACCESSOR__$$",
		function(collection, key) {
			if (argument_count == 2) {
				return collection[? key];	
			}
			
			collection[? key] = argument[2];
		},
		"$$__LIST_ACCESSOR__$$",
		function(collection, key) {
			if (argument_count == 2) {
				return collection[| key];	
			}
			
			collection[| key] = argument[2];
		},
		"$$__GRID_ACCESSOR__$$",
		function(collection, key1, key2) {
			if (argument_count == 3) {
				return collection[# key1, key2];	
			}
			
			collection[# key1, key2] = argument[3];
		},
		"$$__ALARM_ACCESSOR__$$",
		method(undefined, function(key) {
			if (argument_count == 1) {
				return alarm[key];	
			}
			
			alarm[key] = argument[1];	
		})
	);
	#endregion
}