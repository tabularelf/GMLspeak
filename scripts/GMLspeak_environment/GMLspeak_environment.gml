function GMLspeakEnvironment() : CatspeakEnvironment() constructor {
	self.parserType = GMLspeakParser;
	self.lexerType = GMLspeakLexer;
	enableSharedGlobal(true);
	
	//self.codegenType = GMLspeakGMLCompiler;
	//useGMLGlobal(false);
	//
	//static __parentCompile = compile;
	//
	//static compile = function(ir) {
	//	var result = __parentCompile(ir);
	//	
	//	return method({program:  result, args: [], global_: sharedGlobalStruct}, __gmlspeak_program__);
	//}
	//
	//static compileGML = compile;
	//
	//static useGMLGlobal = function(value) {
	//	if (value) {
	//		sharedGlobalStruct =  (method(global, function() {return self;}))();
	//		interface.exposeConstant("global", sharedGlobalStruct);
	//	} else {
	//		sharedGlobalStruct = sharedGlobal ?? {};
	//		interface.exposeConstant("global", sharedGlobalStruct);	
	//	}
	//}
	
	#region Keywords
	renameKeyword(
        "let", "var",
        "fun", "function",
        "impl", "constructor", // Not implemented
		"params", "arguments", // Not implemented
    );
	
	removeKeyword(
		"|>",
		"<|"
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
		//"other",			GMLspeakToken.OTHER,
		
		// Implemented as comments since these kind of act like two separate comments.
		// What could go wrong? *foreshadows*
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
		"with",				GMLspeakToken.WITH,
		"??",				GMLspeakToken.NULLISH,
		"??=",				GMLspeakToken.NULLISH_ASSIGN,
		"?",				GMLspeakToken.CONDITIONAL_OPERATOR,
	);
	
	interface.exposeDynamicConstant(
		"other", function() {
			return global.__catspeakGmlOther ?? sharedGlobal;	
		},
		"$$__KEYBOARD_STRING_GETTER__$$", 
		function() {
			return keyboard_string;	
		}
	);
	
	interface.exposeConstant("global", sharedGlobal);
	
	interface.exposeFunction( 
		"method",
		catspeak_method,
		"$$__SCOPE_PUSH__$$",
		gmlspeak_push_scope,
		"$$__SCOPE_POP__$$",
		gmlspeak_pop_scope,
		"$$__IS_NOT_NULLISH__$$", 
		function(value) {
			return (value != undefined) && (value != pointer_null);	
		}
	);
	#endregion
	
	#region Constants & Dynamic Constants
	
	#region General/Misc
	// Global is passed by default, can be banned via interface.addBanList("global")
	
	interface.exposeConstant( 
		"gamespeed_fps",					gamespeed_fps,
		"tm_countvsyncs",					tm_countvsyncs,
		"tm_sleep",							tm_sleep,
		"gamespeed_microseconds",			gamespeed_microseconds,
		"spritespeed_framespersecond",		spritespeed_framespersecond,
		"spritespeed_framespergameframe",	spritespeed_framespergameframe,
		"timezone_local",					timezone_local,
		"timezone_utc",						timezone_utc,
		"GM_version",						GM_version,
		"GM_build_type",					GM_build_type,
		"GM_build_date",					GM_build_date,
		"GM_runtime_version",				GM_runtime_version,
		"pointer_invalid",					pointer_invalid,
		"pointer_null",						pointer_null,
		"dll_stdcall",						dll_stdcall,
		"dll_cdecl",						dll_cdecl,
		"ty_real",							ty_real,
		"ty_string",						ty_string,
		"all",								all,
		"noone",							noone,
		"infinity",							infinity,
		"pi",								pi,
		"display_landscape_flipped",		display_landscape_flipped,
		"display_portrait_flipped",			display_portrait_flipped,
		"display_landscape",				display_landscape,
		"display_portrait",					display_portrait
	);
	
	interface.exposeDynamicConstant( 
		"webgl_enabled", function() {return webgl_enabled;},
		"fps", function() {return fps;},
		"fps_real", function() {return fps_real;},
		"delta_time", function() {return delta_time;},
		"current_time", function() {return current_time;},
		"application_surface", function() {return application_surface;},
		"current_year", function() {return current_year;},
		"current_month", function() {return current_month;},
		"current_day", function() {return current_day;},
		"current_hour", function() {return current_hour;},
		"current_minute", function() {return current_minute;},
		"current_second", function() {return current_second;},
		"instance_count", function() {return instance_count;},
	);
	#endregion
	
	#region Mouse, Keyboard & Gamepad
	
	#region Keyboard
	// Dynamic Constants
	interface.exposeDynamicConstant( 
		"keyboard_key", function() {return keyboard_key;},
		"keyboard_lastkey", function() {return keyboard_lastkey;},
		"keyboard_lastchar", function() {return keyboard_lastchar;},
		"keyboard_string", function() {return keyboard_string;},
		
	);
	
	interface.exposeConstant(
		"vk_nokey",			vk_nokey,
		"vk_anykey",		vk_anykey,
		"vk_enter",			vk_enter,
		"vk_return",		vk_return,
		"vk_shift",			vk_shift,
		"vk_control",		vk_control,
		"vk_alt",			vk_alt,
		"vk_escape",		vk_escape,
		"vk_space",			vk_space,
		"vk_backspace",		vk_backspace,
		"vk_tab",			vk_tab,
		"vk_pause",			vk_pause,
		"vk_printscreen",	vk_printscreen,
		"vk_left",			vk_left,
		"vk_right",			vk_right,
		"vk_up",			vk_up,
		"vk_down",			vk_down,
		"vk_home",			vk_home,
		"vk_end",			vk_end,
		"vk_delete",		vk_delete,
		"vk_insert",		vk_insert,
		"vk_pageup",		vk_pageup,
		"vk_pagedown",		vk_pagedown,
		"vk_f1",			vk_f1,
		"vk_f2",			vk_f2,
		"vk_f3",			vk_f3,
		"vk_f4",			vk_f4,
		"vk_f5",			vk_f5,
		"vk_f6",			vk_f6,
		"vk_f7",			vk_f7,
		"vk_f8",			vk_f8,
		"vk_f9",			vk_f9,
		"vk_f10",			vk_f10,
		"vk_f11",			vk_f11,
		"vk_f12",			vk_f12, 
		"vk_numpad0",		vk_numpad0,
		"vk_numpad1",		vk_numpad1,
		"vk_numpad2",		vk_numpad2,
		"vk_numpad3",		vk_numpad3,
		"vk_numpad4",		vk_numpad4,
		"vk_numpad5",		vk_numpad5,
		"vk_numpad6",		vk_numpad6,
		"vk_numpad7",		vk_numpad7,
		"vk_numpad8",		vk_numpad8,
		"vk_numpad9",		vk_numpad9,
		"vk_divide",		vk_divide,
		"vk_multiply",		vk_multiply,
		"vk_subtract",		vk_subtract,
		"vk_add",			vk_add,
		"vk_decimal",		vk_decimal,
		"vk_lshift",		vk_lshift,
		"vk_lcontrol",		vk_lcontrol,
		"vk_lalt",			vk_lalt,
		"vk_rshift",		vk_rshift,
		"vk_rcontrol",		vk_rcontrol,
		"vk_ralt",			vk_ralt
	);
	#endregion
	
	#region Virtual Keyboard
	interface.exposeConstant( 
		"kbv_type_default",						kbv_type_default,
		"kbv_type_ascii",						kbv_type_ascii,
		"kbv_type_url",							kbv_type_url,
		"kbv_type_email",						kbv_type_email,
		"kbv_type_numbers",						kbv_type_numbers,
		"kbv_type_phone",						kbv_type_phone,
		"kbv_type_phone_name",					kbv_type_phone_name,
		"kbv_returnkey_default",				kbv_returnkey_default,
		"kbv_returnkey_go",						kbv_returnkey_go,
		"kbv_returnkey_google",					kbv_returnkey_google,
		"kbv_returnkey_join",					kbv_returnkey_join,
		"kbv_returnkey_next",					kbv_returnkey_next,
		"kbv_returnkey_route",					kbv_returnkey_route,
		"kbv_returnkey_search",					kbv_returnkey_search,
		"kbv_returnkey_send",					kbv_returnkey_send,
		"kbv_returnkey_yahoo",					kbv_returnkey_yahoo,
		"kbv_returnkey_done",					kbv_returnkey_done,
		"kbv_returnkey_continue",				kbv_returnkey_continue,
		"kbv_returnkey_emergency",				kbv_returnkey_emergency,
		"kbv_autocapitalize_none",				kbv_autocapitalize_none,
		"kbv_autocapitalize_words",				kbv_autocapitalize_words,
		"kbv_autocapitalize_sentences",			kbv_autocapitalize_sentences,
		"kbv_autocapitalize_characters",		kbv_autocapitalize_characters

	);
	#endregion
	
	#region Mouse
	// Dynamic Constants
	interface.exposeDynamicConstant(
		"mouse_button", function() {return mouse_button;},
		"mouse_x", function() {return mouse_x;},
		"mouse_y", function() {return mouse_y;},
	);
	
	interface.exposeConstant( 
		"mb_left",		mb_left,
		"mb_right",		mb_right,
		"mb_any",		mb_any,
		"mb_middle",	mb_middle,
		"mb_side1",		mb_side1,
		"mb_side2",		mb_side2,
		"mb_none",		mb_none
	);
	
	interface.exposeConstant( 
		"cr_none",			cr_none,			
		"cr_default",		cr_default,
		"cr_arrow",			cr_arrow,
		"cr_cross",			cr_cross,
		"cr_beam",			cr_beam,
		"cr_size_nesw",		cr_size_nesw,
		"cr_size_ns",		cr_size_ns,
		"cr_size_nwse",		cr_size_nwse,
		"cr_size_we",		cr_size_we,
		"cr_uparrow",		cr_uparrow,
		"cr_hourglass",		cr_hourglass,
		"cr_drag",			cr_drag,
		"cr_appstart" ,		cr_appstart,
		"cr_handpoint",		cr_handpoint,
		"cr_size_all", 		cr_size_all,
	);
	#endregion

	#region Gamepad
	interface.exposeConstant( 
		"gp_face1",							gp_face1,
		"gp_face2",							gp_face2,
		"gp_face3",							gp_face3,
		"gp_face4",							gp_face4,
		"gp_shoulderl",						gp_shoulderl,
		"gp_shoulderlb",					gp_shoulderlb,
		"gp_shoulderr",						gp_shoulderr,
		"gp_shoulderrb",					gp_shoulderrb,
		"gp_select",						gp_select,
		"gp_start",							gp_start,
		"gp_stickl",						gp_stickl,
		"gp_stickr",						gp_stickr,
		"gp_padu",							gp_padu,
		"gp_padd",							gp_padd,
		"gp_padl",							gp_padl,
		"gp_padr",							gp_padr,
		"gp_axislh",						gp_axislh,
		"gp_axislv",						gp_axislv,
		"gp_axisrh",						gp_axisrh,
		"gp_axisrv",						gp_axisrv,
		"gp_axis_acceleration_x",			gp_axis_acceleration_x,
		"gp_axis_acceleration_y",			gp_axis_acceleration_y,
		"gp_axis_acceleration_z",			gp_axis_acceleration_z,
		"gp_axis_angular_velocity_x",		gp_axis_angular_velocity_x,
		"gp_axis_angular_velocity_y",		gp_axis_angular_velocity_y,
		"gp_axis_angular_velocity_z",		gp_axis_angular_velocity_z,
		"gp_axis_orientation_x",			gp_axis_orientation_x,
		"gp_axis_orientation_y",			gp_axis_orientation_y,
		"gp_axis_orientation_z",			gp_axis_orientation_z,
		"gp_axis_orientation_w",			gp_axis_orientation_w
	);
	#endregion
	
	#endregion
	
	#region Dynamic Resources & Assets
	
	#region Video Playback
	interface.exposeConstant( 
		"video_format_rgba",		video_format_rgba,
		"video_format_yuv",			video_format_yuv,
		"video_status_closed",		video_status_closed,
		"video_status_preparing",	video_status_preparing,
		"video_status_playing",		video_status_playing,
		"video_status_paused",		video_status_paused
	);
	#endregion
	
	#region Vertex & Primitives
	// Vertex Buffers Attributes
	interface.exposeConstant(
		"vertex_usage_position", vertex_usage_position,
		"vertex_usage_colour", vertex_usage_colour,
		"vertex_usage_color", vertex_usage_color,
		"vertex_usage_normal", vertex_usage_normal,
		"vertex_usage_textcoord", vertex_usage_textcoord,
		"vertex_usage_texcoord", vertex_usage_texcoord,
		"vertex_usage_blendweight", vertex_usage_blendweight,
		"vertex_usage_blendindices", vertex_usage_blendindices,
		"vertex_usage_psize", vertex_usage_psize,
		"vertex_usage_tangent", vertex_usage_tangent,
		"vertex_usage_binormal", vertex_usage_binormal,
		"vertex_usage_fog", vertex_usage_fog,
		"vertex_usage_depth", vertex_usage_depth,
		"vertex_usage_sample", vertex_usage_sample,
		"vertex_type_float1", vertex_type_float1,
		"vertex_type_float2", vertex_type_float2,
		"vertex_type_float3", vertex_type_float3,
		"vertex_type_float4", vertex_type_float4,
		"vertex_type_colour", vertex_type_colour,
		"vertex_type_color", vertex_type_color,
		"vertex_type_ubyte4", vertex_type_ubyte4
	);
	
	interface.exposeConstant(
		"pr_pointlist", pr_pointlist,
		"pr_linelist", pr_linelist,
		"pr_linestrip", pr_linestrip,
		"pr_trianglelist", pr_trianglelist,
		"pr_trianglestrip", pr_trianglestrip,
		"pr_trianglefan", pr_trianglefan
	);
	#endregion
	
	#region Buffers 
	interface.exposeConstant(
		"buffer_fixed",			buffer_fixed,
		"buffer_grow",			buffer_grow,
		"buffer_wrap",			buffer_wrap,
		"buffer_fast",			buffer_fast,
		"buffer_vbuffer",		buffer_vbuffer,
		"buffer_u8",			buffer_u8,
		"buffer_s8",			buffer_s8,
		"buffer_u16",			buffer_u16,
		"buffer_s16",			buffer_s16,
		"buffer_u32",			buffer_u32,
		"buffer_s32",			buffer_s32,
		"buffer_f16",			buffer_f16,
		"buffer_f32",			buffer_f32,
		"buffer_f64",			buffer_f64,
		"buffer_u64",			buffer_u64,
		"buffer_bool",			buffer_bool,
		"buffer_string",		buffer_string,
		"buffer_text",			buffer_text,
		"buffer_seek_start",	buffer_seek_start,
		"buffer_seek_relative", buffer_seek_relative,
		"buffer_seek_end",		buffer_seek_end
	);
	#endregion
	
	#region Data Structures
	interface.exposeConstant( 
		"ds_type_map", ds_type_map,
		"ds_type_list", ds_type_list,
		"ds_type_stack", ds_type_stack,
		"ds_type_queue", ds_type_queue,
		"ds_type_grid", ds_type_grid,
		"ds_type_priority", ds_type_priority
	);
	#endregion
	
	#region Time Sources
	interface.exposeConstant( 
		"time_source_units_frames",		time_source_units_frames,
		"time_source_units_seconds",	time_source_units_seconds,
		"time_source_global",			time_source_global,
		"time_source_game",				time_source_game,
		"time_source_units_seconds",	time_source_units_seconds,
		"time_source_units_frames",		time_source_units_frames,
		"time_source_expire_nearest",	time_source_expire_nearest,
		"time_source_expire_after",		time_source_expire_after,
		"time_source_state_initial",	time_source_state_initial,
		"time_source_state_active",		time_source_state_active,
		"time_source_state_paused",		time_source_state_paused,
		"time_source_state_stopped",	time_source_state_stopped

	);
	#endregion
	
	#region Sequences
	interface.exposeConstant( 
		"seqplay_oneshot", seqplay_oneshot,
		"seqplay_loop", seqplay_loop,
		"seqplay_pingpong", seqplay_pingpong,
		"seqdir_right", seqdir_right,
		"seqdir_left", seqdir_left,
		"seqtracktype_graphic", seqtracktype_graphic,
		"seqtracktype_audio", seqtracktype_audio,
		"seqtracktype_real", seqtracktype_real,
		"seqtracktype_color", seqtracktype_color,
		"seqtracktype_colour", seqtracktype_colour,
		"seqtracktype_bool", seqtracktype_bool,
		"seqtracktype_string", seqtracktype_string,
		"seqtracktype_sequence", seqtracktype_sequence,
		"seqtracktype_clipmask", seqtracktype_clipmask,
		"seqtracktype_clipmask_mask", seqtracktype_clipmask_mask,
		"seqtracktype_clipmask_subject", seqtracktype_clipmask_subject,
		"seqtracktype_group", seqtracktype_group,
		"seqtracktype_empty", seqtracktype_empty,
		"seqtracktype_spriteframes", seqtracktype_spriteframes,
		"seqtracktype_instance", seqtracktype_instance,
		"seqtracktype_message", seqtracktype_message,
		"seqtracktype_moment", seqtracktype_moment,
		"animcurvetype_linear", animcurvetype_linear,
		"animcurvetype_catmullrom", animcurvetype_catmullrom,
		"seqaudiokey_loop", seqaudiokey_loop,
		"seqaudiokey_oneshot", seqaudiokey_oneshot,
		"seqinterpolation_assign", seqinterpolation_assign,
		"seqinterpolation_lerp", seqinterpolation_lerp,
	);
	#endregion
	
	#region Asset Types 
	interface.exposeConstant( 
		"asset_unknown", asset_unknown,
		"asset_sprite", asset_sprite,
		"asset_object", asset_object,
		"asset_script", asset_script,
		"asset_room", asset_room,
		"asset_path", asset_path,
		"asset_sound", asset_sound,
		"asset_tiles", asset_tiles,
		"asset_timeline", asset_timeline,
		"asset_font", asset_font,
		"asset_shader", asset_shader,
		"asset_sequence", asset_sequence,
		"asset_animationcurve", asset_animationcurve
	);
	#endregion
	
	#region Nineslice
	interface.exposeConstant( 
		"nineslice_left",       nineslice_left,
		"nineslice_top", 		nineslice_top, 
		"nineslice_right",		nineslice_right,
		"nineslice_bottom", 	nineslice_bottom, 
		"nineslice_centre", 	nineslice_centre, 
		"nineslice_stretch",	nineslice_stretch,
		"nineslice_repeat", 	nineslice_repeat, 
		"nineslice_blank",		nineslice_blank,
		"nineslice_mirror",		nineslice_mirror,
		"nineslice_hide",		nineslice_hide,
		"nineslice_center",		nineslice_center

	);
	#endregion
	
	#region Particle types & Emitters
	interface.exposeConstant(
		"pt_shape_circle", pt_shape_circle, 
		"pt_shape_cloud", pt_shape_cloud, 
		"pt_shape_disk", pt_shape_disk, 
		"pt_shape_explosion", pt_shape_explosion, 
		"pt_shape_flare", pt_shape_flare, 
		"pt_shape_line", pt_shape_line, 
		"pt_shape_pixel", pt_shape_pixel, 
		"pt_shape_ring", pt_shape_ring, 
		"pt_shape_smoke", pt_shape_smoke, 
		"pt_shape_snow", pt_shape_snow, 
		"pt_shape_spark", pt_shape_spark, 
		"pt_shape_square", pt_shape_square, 
		"pt_shape_star", pt_shape_star,
		"pt_shape_sphere", pt_shape_sphere
	);
	
	interface.exposeConstant(
		"ps_distr_linear", ps_distr_linear,
		"ps_distr_gaussian", ps_distr_gaussian,
		"ps_distr_invgaussian", ps_distr_invgaussian,
		"ps_shape_rectangle", ps_shape_rectangle,
		"ps_shape_ellipse", ps_shape_ellipse,
		"ps_shape_diamond", ps_shape_diamond,
		"ps_shape_line", ps_shape_line
	);
	
	interface.exposeConstant( 
		"ef_cloud",		ef_cloud, 
		"ef_ellipse",	ef_ellipse,
		"ef_explosion",	ef_explosion,
		"ef_firework", 	ef_firework, 
		"ef_flare",		ef_flare,
		"ef_rain",		ef_rain,
		"ef_ring",		ef_ring,
		"ef_smoke",		ef_smoke,
		"ef_smokeup",	ef_smokeup,
		"ef_snow",		ef_snow,
		"ef_spark",		ef_spark,
		"ef_star",		ef_star,		

	);
	#endregion
	
	#region Paths
	interface.exposeConstant(
		"path_action_stop", path_action_stop,
		"path_action_restart", path_action_restart,
		"path_action_continue", path_action_continue,
		"path_action_reverse", path_action_reverse
	);
	#endregion
	
	#region Audio
	interface.exposeConstant( 
		"audio_3d", audio_3d,
		"audio_mono", audio_mono,
		"audio_stereo", audio_stereo,
		"audio_falloff_none", audio_falloff_none,
		"audio_falloff_inverse_distance", audio_falloff_inverse_distance,
		"audio_falloff_inverse_distance_clamped", audio_falloff_inverse_distance_clamped,
		"audio_falloff_linear_distance", audio_falloff_linear_distance,
		"audio_falloff_linear_distance_clamped", audio_falloff_linear_distance_clamped,
		"audio_falloff_exponent_distance", audio_falloff_exponent_distance,
		"audio_falloff_exponent_distance_clamped", audio_falloff_exponent_distance_clamped,
		"audio_falloff_exponent_distance_scaled", audio_falloff_exponent_distance_scaled
	);
	#endregion
	
	#region Room & Layers 
	interface.exposeConstant( 
		"layerelementtype_undefined", layerelementtype_undefined,
		"layerelementtype_background", layerelementtype_background,
		"layerelementtype_instance", layerelementtype_instance,
		"layerelementtype_oldtilemap", layerelementtype_oldtilemap,
		"layerelementtype_sprite", layerelementtype_sprite,
		"layerelementtype_tilemap", layerelementtype_tilemap,
		"layerelementtype_particlesystem", layerelementtype_particlesystem,
		"layerelementtype_tile", layerelementtype_tile,
		"layerelementtype_sequence", layerelementtype_sequence,
	);
	
	interface.exposeDynamicConstant( 
		"room_first", function() {return room_first;},
		"room_last", function() {return room_last;},
	);
	
	interface.exposeDynamicConstant( 
		"room", function() {return room;},
		"room_width", function() {return room_width;},
		"room_height", function() {return room_width;},
	);
	#endregion
	
	#region Tiles
	interface.exposeConstant( 
		"tile_rotate",		tile_rotate,
		"tile_mirror",		tile_mirror,
		"tile_flip",		tile_flip,
		"tile_index_mask",	tile_index_mask
	);
	#endregion
	
	#region bbox
	interface.exposeConstant(
		"bboxmode_automatic",	bboxmode_automatic,
		"bboxmode_fullimage",	bboxmode_fullimage,
		"bboxmode_manual",		bboxmode_manual,
		"bboxkind_rectangular",	bboxkind_rectangular,
		"bboxkind_ellipse",		bboxkind_ellipse,
		"bboxkind_diamond",		bboxkind_diamond,
		"bboxkind_precise",		bboxkind_precise

	);
	#endregion
	
	#region Physics
	interface.exposeConstant( 
		"phy_joint_anchor_1_x",				phy_joint_anchor_1_x,
		"phy_joint_anchor_1_y",				phy_joint_anchor_1_y,
		"phy_joint_anchor_2_x",				phy_joint_anchor_2_x,
		"phy_joint_anchor_2_y",				phy_joint_anchor_2_y,
		"phy_joint_reaction_force_x",		phy_joint_reaction_force_x,
		"phy_joint_reaction_force_y",		phy_joint_reaction_force_y,
		"phy_joint_reaction_torque",		phy_joint_reaction_torque,
		"phy_joint_max_motor_force",		phy_joint_max_motor_force,
		"phy_joint_max_motor_torque",		phy_joint_max_motor_torque,
		"phy_joint_motor_force",			phy_joint_motor_force,
		"phy_joint_motor_speed",			phy_joint_motor_speed,
		"phy_joint_motor_torque",			phy_joint_motor_torque,
		"phy_joint_angle",					phy_joint_angle,
		"phy_joint_angle_limits",			phy_joint_angle_limits,
		"phy_joint_upper_angle_limit",		phy_joint_upper_angle_limit,
		"phy_joint_lower_angle_limit",		phy_joint_lower_angle_limit,
		"phy_joint_translation",			phy_joint_translation,
		"phy_joint_speed",					phy_joint_speed,
		"phy_joint_damping_ratio",			phy_joint_damping_ratio,
		"phy_joint_frequency",				phy_joint_frequency,
		"phy_joint_length_1",				phy_joint_length_1,
		"phy_joint_length_2",				phy_joint_length_2,
		"phy_joint_max_torque",				phy_joint_max_torque,
		"phy_joint_max_force",				phy_joint_max_force,
		"phy_joint_max_length",				phy_joint_max_length,
		"phy_particle_flag_water",			phy_particle_flag_water,
		"phy_particle_flag_zombie",			phy_particle_flag_zombie,
		"phy_particle_flag_wall",			phy_particle_flag_wall,
		"phy_particle_flag_spring",			phy_particle_flag_spring,
		"phy_particle_flag_elastic",		phy_particle_flag_elastic,
		"phy_particle_flag_viscous",		phy_particle_flag_viscous,
		"phy_particle_flag_powder",			phy_particle_flag_powder,
		"phy_particle_flag_tensile",		phy_particle_flag_tensile,
		"phy_particle_flag_colourmixing	",	phy_particle_flag_colourmixing,
		"phy_particle_flag_colormixing",	phy_particle_flag_colormixing,
		"phy_particle_data_flag_typeflags",	phy_particle_data_flag_typeflags,
		"phy_particle_data_flag_position",	phy_particle_data_flag_position,
		"phy_particle_data_flag_velocity",	phy_particle_data_flag_velocity,
		"phy_particle_data_flag_colour",	phy_particle_data_flag_colour,
		"phy_particle_data_flag_color",		phy_particle_data_flag_colour,
		"phy_particle_data_flag_category",	phy_particle_data_flag_category,
		"phy_particle_group_flag_solid",	phy_particle_group_flag_solid,
		"phy_particle_group_flag_rigid",	phy_particle_group_flag_rigid,
		"phy_debug_render_aabb",			phy_debug_render_aabb,
		"phy_debug_render_collision_pairs",	phy_debug_render_collision_pairs,
		"phy_debug_render_coms",			phy_debug_render_coms,
		"phy_debug_render_core_shapes",		phy_debug_render_core_shapes,
		"phy_debug_render_joints",			phy_debug_render_joints,
		"phy_debug_render_obb",				phy_debug_render_obb,
		"phy_debug_render_shapes",			phy_debug_render_shapes
	);
	#endregion
	
	#endregion
	
	#region Drawing
	// Text allignment
	interface.exposeConstant( 
		"fa_left", fa_left,
		"fa_right", fa_right,
		"fa_center", fa_center,
		"fa_top", fa_top,
		"fa_middle", fa_middle,
		"fa_bottom", fa_bottom
	);
	
	#region Colours
	interface.exposeConstant( 
		"c_aqua",		c_aqua,
		"c_black", 		c_black, 
		"c_blue", 		c_blue, 
		"c_dkgray",		c_dkgray,
		"c_fuchsia",	c_fuchsia,
		"c_gray", 		c_gray, 
		"c_green", 		c_green, 
		"c_lime", 		c_lime, 
		"c_ltgray",		c_ltgray,
		"c_maroon",		c_maroon,
		"c_navy", 		c_navy, 
		"c_olive" ,		c_olive,
		"c_orange",		c_orange,
		"c_purple",		c_purple,
		"c_red", 		c_red, 
		"c_silver",		c_silver,
		"c_teal",		c_teal,
		"c_white",		c_white,
		"c_yellow",		c_yellow
	);
	#endregion
	
	#region Blendmodes
	interface.exposeConstant( 
		"bm_normal", bm_normal,
		"bm_add", bm_add,
		"bm_max", bm_max,
		"bm_subtract", bm_subtract,
		"bm_zero", bm_zero,
		"bm_one", bm_one,
		"bm_src_color", bm_src_color,
		"bm_inv_src_color", bm_inv_src_color,
		"bm_src_colour", bm_src_colour,
		"bm_inv_src_colour", bm_inv_src_colour,
		"bm_src_alpha", bm_src_alpha,
		"bm_inv_src_alpha", bm_inv_src_alpha,
		"bm_dest_alpha", bm_dest_alpha,
		"bm_inv_dest_alpha", bm_inv_dest_alpha,
		"bm_dest_color", bm_dest_color,
		"bm_inv_dest_color", bm_inv_dest_color,
		"bm_dest_colour", bm_dest_colour,
		"bm_src_alpha_sat", bm_src_alpha_sat
	);
	#endregion
	
	#region Lighting
	interface.exposeConstant( 
		"lighttype_dir", lighttype_dir,
		"lighttype_point", lighttype_point
	);
	#endregion
	
	#region Culling and depth testing
	interface.exposeConstant( 
		"cmpfunc_never", cmpfunc_never,
		"cmpfunc_less", cmpfunc_less,
		"cmpfunc_equal", cmpfunc_equal,
		"cmpfunc_lessequal", cmpfunc_lessequal,
		"cmpfunc_greater", cmpfunc_greater,
		"cmpfunc_notequal", cmpfunc_notequal,
		"cmpfunc_greaterequal", cmpfunc_greaterequal,
		"cmpfunc_always", cmpfunc_always,
		"cull_noculling", cull_noculling,
		"cull_clockwise", cull_clockwise,
		"cull_counterclockwise", cull_counterclockwise
	);
	#endregion
	
	#region Matrix
	interface.exposeConstant( 
		"matrix_view", matrix_view,
		"matrix_projection", matrix_projection,
		"matrix_world", matrix_world
	);
	#endregion
	
	#region Mipmap & Texture filtering
	interface.exposeConstant( 
		"mip_markedonly", mip_markedonly,
		"mip_on", mip_on,
		"mip_off", mip_off,
		"tf_point", tf_point,
		"tf_anisotropic", tf_anisotropic,
		"tf_linear", tf_linear
	);
	#endregion
	#endregion
	
	#region OS, Devices and Browsers
	interface.exposeConstant( 
		"os_windows", os_windows,
		"os_gxgames", os_gxgames,
		"os_macosx", os_macosx,
		"os_linux", os_linux,
		"os_ios", os_ios,
		"os_android", os_android,
		"os_tvos", os_tvos,
		"os_unknown", os_unknown,
		"os_ps5", os_ps5,
		"os_ps4", os_ps4,
		"os_xboxseriesxs", os_xboxseriesxs,
		"os_gdk", os_gdk,
		"os_switch", os_switch,
		"os_operagx", os_operagx,
		"browser_chrome", browser_chrome,
		"browser_safari", browser_safari,
		"browser_safari_mobile", browser_safari_mobile,
		"browser_firefox", browser_firefox,
		"browser_ie", browser_ie,
		"browser_edge", browser_edge,
		"browser_windows_store", browser_windows_store,
		//"browser_tizen", browser_tizen,
		"browser_ie_mobile", browser_ie_mobile,
		"browser_opera", browser_opera,
		"browser_not_a_browser", browser_not_a_browser,
		"browser_unknown", browser_unknown,
		"device_emulator", device_emulator,
		"device_ios_ipad_retina", device_ios_ipad_retina,
		"device_ios_ipad", device_ios_ipad,
		"device_ios_iphone6", device_ios_iphone6,
		"device_ios_iphone6plus", device_ios_iphone6plus,
		"device_ios_iphone5", device_ios_iphone5,
		"device_ios_iphone", device_ios_iphone,
		"device_ios_iphone_retina", device_ios_iphone_retina,
		"device_tablet", device_tablet,
		"device_ios_unknown", device_ios_unknown,
		"os_permission_granted", os_permission_granted,
		"os_permission_denied", os_permission_denied,
		"os_permission_denied_dont_request", os_permission_denied_dont_request
	);
	
	interface.exposeDynamicConstant( 
		"os_browser", function() {return os_browser;},
		"os_version", function() {return os_version;},
		"os_device", function() {return os_device;},
		// This technically doesn't need to be dynamic but just in case...
		"os_type", function() {return os_type;}
	);
	#endregion
	
	#region Events
	interface.exposeDynamicConstant( 
		"event_type", function() {return event_type;},
		"event_number", function() {return event_number;},
		"async_load", function() {return async_load;},
		"event_data", function() {return event_data;},
	);
	
	interface.exposeConstant( 
		"ev_create", ev_create,
		"ev_no_more_lives", ev_no_more_lives,
		"ev_no_more_health", ev_no_more_health,
		
		"ev_gesture", ev_gesture,
		"ev_gesture_double_tap", ev_gesture_double_tap,
		"ev_gesture_drag_end", ev_gesture_drag_end,
		"ev_gesture_drag_start", ev_gesture_drag_start,
		"ev_gesture_dragging", ev_gesture_dragging,
		"ev_gesture_tap", ev_gesture_tap,
		"ev_gesture_rotating", ev_gesture_rotating,
		"ev_gesture_rotate_end", ev_gesture_rotate_end,
		"ev_gesture_rotate_start", ev_gesture_rotate_start,
		"ev_gesture_flick", ev_gesture_flick,
		"ev_gesture_pinch_start", ev_gesture_pinch_start,
		"ev_gesture_pinch_in", ev_gesture_pinch_in,
		"ev_gesture_pinch_out", ev_gesture_pinch_out,
		"ev_gesture_pinch_end", ev_gesture_pinch_end,
		
		// This seems to not exist, but it also does?? idk, crashes
		//"ev_global_gesture", ev_global_gesture,
		"ev_global_gesture_double_tap", ev_global_gesture_double_tap,
		"ev_global_gesture_drag_end", ev_global_gesture_drag_end,
		"ev_global_gesture_drag_start", ev_global_gesture_drag_start,
		"ev_global_gesture_dragging", ev_global_gesture_dragging,
		"ev_global_gesture_tap", ev_global_gesture_tap,
		"ev_global_gesture_rotating", ev_global_gesture_rotating,
		"ev_global_gesture_rotate_end", ev_global_gesture_rotate_end,
		"ev_global_gesture_rotate_start", ev_global_gesture_rotate_start,
		"ev_global_gesture_flick", ev_global_gesture_flick,
		"ev_global_gesture_pinch_start", ev_global_gesture_pinch_start,
		"ev_global_gesture_pinch_in", ev_global_gesture_pinch_in,
		"ev_global_gesture_pinch_out", ev_global_gesture_pinch_out,
		"ev_global_gesture_pinch_end", ev_global_gesture_pinch_end,
		
		"ev_destroy", ev_destroy,
		"ev_step", ev_step,
		"ev_alarm", ev_alarm,
		"ev_keyboard", ev_keyboard,
		"ev_mouse", ev_mouse,
		"ev_collision", ev_collision,
		"ev_other", ev_other,
		"ev_draw", ev_draw,
		"ev_keypress", ev_keypress,
		"ev_keyrelease", ev_keyrelease,
		"ev_cleanup", ev_cleanup,
		"ev_gesture", ev_gesture,
		"ev_room_end", ev_room_end,
		"ev_room_start", ev_room_start,
		"ev_game_end", ev_game_end,
		"ev_game_start", ev_game_start,
		"ev_pre_create", ev_pre_create,
		"ev_left_button", ev_left_button,
		"ev_right_button", ev_right_button,
		"ev_middle_button", ev_middle_button,
		"ev_no_button", ev_no_button,
		"ev_left_press", ev_left_press,
		"ev_right_press", ev_right_press,
		"ev_middle_press", ev_middle_press,
		"ev_left_release", ev_left_release,
		"ev_right_release", ev_right_release,
		"ev_middle_release", ev_middle_release,
		"ev_mouse_enter", ev_mouse_enter,
		"ev_mouse_leave", ev_mouse_leave,
		"ev_global_left_press", ev_global_left_press,
		"ev_global_right_press", ev_global_right_press,
		"ev_global_left_release", ev_global_left_release,
		"ev_global_right_release", ev_global_right_release,
		"ev_global_left_button", ev_global_left_button,
		"ev_global_right_button", ev_global_right_button,
		"ev_global_middle_press", ev_global_middle_press,
		"ev_global_middle_release", ev_global_middle_release,
		"ev_global_middle_button", ev_global_middle_button,
		"ev_draw_begin", ev_draw_begin,
		"ev_draw_end", ev_draw_end,
		"ev_draw_pre", ev_draw_pre,
		"ev_draw_post", ev_draw_post,
		"ev_gui_begin", ev_gui_begin,
		"ev_gui_end", ev_gui_end,
		"ev_gui", ev_gui,
		"ev_user0", ev_user0,
		"ev_user1", ev_user1,
		"ev_user2", ev_user2,
		"ev_user3", ev_user3,
		"ev_user4", ev_user4,
		"ev_user5", ev_user5,
		"ev_user6", ev_user6,
		"ev_user7", ev_user7,
		"ev_user8", ev_user8,
		"ev_user9", ev_user9,
		"ev_user10", ev_user10,
		"ev_user11", ev_user11,
		"ev_user12", ev_user12,
		"ev_user13", ev_user13,
		"ev_user14", ev_user14,
		"ev_user15", ev_user15,
		"ev_animation_end", ev_animation_end,
		"ev_end_of_path", ev_end_of_path,
		"ev_outside", ev_outside,
		"ev_boundary", ev_boundary,
		"ev_mouse_wheel_down", ev_mouse_wheel_down,
		"ev_mouse_wheel_up", ev_mouse_wheel_up,
		"ev_outside_view0", ev_outside_view0,
		"ev_outside_view1", ev_outside_view1,
		"ev_outside_view2", ev_outside_view2,
		"ev_outside_view3", ev_outside_view3,
		"ev_outside_view4", ev_outside_view4,
		"ev_outside_view5", ev_outside_view5,
		"ev_outside_view6", ev_outside_view6,
		"ev_outside_view7", ev_outside_view7,
		"ev_boundary_view0", ev_boundary_view0,
		"ev_boundary_view1", ev_boundary_view1,
		"ev_boundary_view2", ev_boundary_view2,
		"ev_boundary_view3", ev_boundary_view3,
		"ev_boundary_view4", ev_boundary_view4,
		"ev_boundary_view5", ev_boundary_view5,
		"ev_boundary_view6", ev_boundary_view6,
		"ev_boundary_view7", ev_boundary_view7,
		"ev_collision", ev_collision,
		"ev_broadcast_message", ev_broadcast_message,
		"ev_step_normal", ev_step_normal,
		"ev_step_begin", ev_step_begin,
		"ev_step_end", ev_step_end
	);
	
	interface.exposeConstant( 
		"ev_async_system_event", ev_async_system_event,
		"ev_async_push_notification", ev_async_push_notification,
		"ev_async_web_iap", ev_async_web_iap,
		"ev_async_social", ev_async_social,
		"ev_async_web", ev_async_web,
		"ev_async_web_cloud", ev_async_web_cloud,
		"ev_async_web_image_load", ev_async_web_image_load,
		"ev_async_web_networking", ev_async_web_networking,
		"ev_async_web_steam", ev_async_web_steam,
		"ev_async_audio_playback", ev_async_audio_playback,
		"ev_async_audio_recording", ev_async_audio_recording,
		"ev_async_dialog", ev_async_dialog,
		"ev_async_save_load", ev_async_save_load
	);
	#endregion
	
	#region Networking
	interface.exposeConstant( 
		"network_send_binary",						network_send_binary,
		"network_send_text",						network_send_text,
		"network_socket_tcp",						network_socket_tcp,
		"network_socket_udp",						network_socket_udp,
		"network_socket_ws",						network_socket_ws,
		"network_socket_bluetooth",					network_socket_bluetooth,
		"network_config_connect_timeout",			network_config_connect_timeout,
		"network_config_use_non_blocking_socket",	network_config_use_non_blocking_socket,
		"network_config_enable_reliable_udp",		network_config_enable_reliable_udp,
		"network_config_disable_reliable_udp",		network_config_disable_reliable_udp,
		"network_config_avoid_time_wait",			network_config_avoid_time_wait,
		"network_config_websocket_protocol",		network_config_websocket_protocol,
		"network_connect_none",						network_connect_none,
		"network_connect_blocking",					network_connect_blocking,
		"network_connect_nonblocking",				network_connect_nonblocking,
		"network_type_down",						network_type_down,
		"network_type_up_failed",					network_type_up_failed,
		"network_type_up",							network_type_up,
		"network_type_non_blocking_connect",		network_type_non_blocking_connect,
		"network_type_data",						network_type_data,
		"network_type_connect",						network_type_connect,
		"network_type_disconnect",					network_type_disconnect
	);
	#endregion
	
	#region Non-LTS (Anything that is not in LTS please put them in here)
	/*
		NOTE: Everything here is handled via a try/catch. Since it's not certain that 
	    these specific constants are available.
	*/
	
	#region Audio Bus & Effects
	static __AudioEffectTypeStruct = {};	
	static __AudioLFOType = {};
	try {
		__AudioLFOType.InvSawtooth = AudioLFOType.InvSawtooth;
		__AudioLFOType.Sawtooth = AudioLFOType.Sawtooth;
		__AudioLFOType.Sine = AudioLFOType.Sine;
		__AudioLFOType.Square = AudioLFOType.Square;
		__AudioLFOType.Triangle = AudioLFOType.Triangle;
		
		interface.exposeConstant( 
			"AudioLFOType", __AudioLFOType
		);
	} catch(_) {
		__gmlspeak_log("New Audio Effects unavailable! Skipping...");
	}
	
	try {
		__AudioEffectTypeStruct.Bitcrusher = AudioEffectType.Bitcrusher;
		__AudioEffectTypeStruct.Delay = AudioEffectType.Delay;
		__AudioEffectTypeStruct.Gain = AudioEffectType.Gain;
		__AudioEffectTypeStruct.HPF2 = AudioEffectType.HPF2;
		__AudioEffectTypeStruct.LPF2 = AudioEffectType.LPF2;
		__AudioEffectTypeStruct.Reverb1 = AudioEffectType.Reverb1;
		__AudioEffectTypeStruct.EQ = AudioEffectType.EQ;
		__AudioEffectTypeStruct.LoShelf = AudioEffectType.LoShelf;
		__AudioEffectTypeStruct.HiShelf = AudioEffectType.HiShelf;
		__AudioEffectTypeStruct.PeakEQ = AudioEffectType.PeakEQ;
		__AudioEffectTypeStruct.Tremolo = AudioEffectType.Tremolo;
		__AudioEffectTypeStruct.Compressor = AudioEffectType.Compressor;
		
		interface.exposeConstant( 
			"AudioEffectType", __AudioEffectTypeStruct,
			"audio_bus_main", audio_bus_main
		);
	} catch(_) {
		__gmlspeak_log("Audio Bus & Effects are unavailable! Skipping...");
	}
	#endregion
	
	#region ev_draw_normal
	try {
		interface.exposeConstant( 
			// Not in LTS
			"ev_draw_normal", ev_draw_normal
		);
	} catch(_) {
		__gmlspeak_log("ev_draw_normal not available! Skipping...");	
	} 
	#endregion
	
	#region sprite_add_ext
	try {
		interface.exposeConstant( 
			"sprite_add_ext_error_unknown",				sprite_add_ext_error_unknown,
			"sprite_add_ext_error_cancelled",			sprite_add_ext_error_cancelled,
			"sprite_add_ext_error_spritenotfound",		sprite_add_ext_error_spritenotfound,
			"sprite_add_ext_error_loadfailed",			sprite_add_ext_error_loadfailed,
			"sprite_add_ext_error_decompressfailed",	sprite_add_ext_error_decompressfailed,
			"sprite_add_ext_error_setupfailed",			sprite_add_ext_error_setupfailed
		);
	} catch(_) {
		__gmlspeak_log("sprite_add_ext not available! Skipping...");	
	}
	#endregion
	
	#region Particle System Asset
	try {
		interface.exposeConstant( 
			"asset_particlesystem", asset_particlesystem,
			"layerelementtype_particlesystem", layerelementtype_particlesystem
		);
	} catch(_) {
		__gmlspeak_log("Particle System Asset not available! Skipping...");	
	}
	#endregion
	
	#region Text Asset
	try {
		interface.exposeConstant( 
			"textalign_left", textalign_left,
			"textalign_right", textalign_right,
			"textalign_center", textalign_center,
			"textalign_justify", textalign_justify,
			"textalign_top", textalign_top,
			"textalign_bottom", textalign_bottom,
			"textalign_middle", textalign_middle
		);
	} catch(_) {
		__gmlspeak_log("Text Asset not available! Skipping...");	
	}
	#endregion
	
	#region Surface formats
	try {
	interface.exposeConstant( 
		"surface_rgba8unorm",		surface_rgba8unorm,
		"surface_r8unorm",			surface_r8unorm,
		"surface_rg8unorm",			surface_rg8unorm,
		"surface_rgba4unorm",		surface_rgba4unorm,
		"surface_rgba16float",		surface_rgba16float,
		"surface_r16float",			surface_r16float,
		"surface_rgba32float",		surface_rgba32float,
		"surface_r32float",			surface_r32float
	);
	} catch(_) {
		__gmlspeak_log("Surface formats not available! Skipping...");	
	}
	#endregion
	
	#region Timings 
	try {
		interface.exposeConstant( 
			"tm_systemtiming",		tm_systemtiming
		);
	} catch(_) {
		__gmlspeak_log("tm_systemtiming not available! Skipping...");	
	}
	#endregion
	
	#region Sandbox value 
	try {
		interface.exposeConstant( 
			"GM_is_sandboxed",		GM_is_sandboxed
		);
	} catch(_) {
		__gmlspeak_log("GM_is_sandboxed not available! Skipping...");	
	}
	#endregion
	
	#region Blendmodes Equations
	try {
		interface.exposeConstant( 
			"bm_eq_add",				bm_eq_add,
			"bm_eq_subtract",			bm_eq_subtract,
			"bm_eq_max",				bm_eq_max,
			"bm_eq_min",				bm_eq_min,
			"bm_eq_reverse_subtract",	bm_eq_reverse_subtract
		);
	} catch(_) {
		__gmlspeak_log("Blendmode Equations not available! Skipping...");	
	}
	#endregion
	
	#region Stencil ops
	try {
		interface.exposeConstant( 
			"stencilop_keep",			stencilop_keep,
			"stencilop_zero",			stencilop_zero,
			"stencilop_replace",		stencilop_replace,
			"stencilop_incr_wrap",		stencilop_incr_wrap,
			"stencilop_decr_wrap",		stencilop_decr_wrap,
			"stencilop_invert",			stencilop_invert,
			"stencilop_incr",			stencilop_incr,
			"stencilop_decr",			stencilop_decr
		);
	} catch(_) {
		__gmlspeak_log("Stencil Operations not available! Skipping...");	
	}
	#endregion
	
	#region New gamepad constants
	try {
		interface.exposeConstant( 
			"gp_home",				gp_home,
			"gp_extra1",			gp_extra1,
			"gp_extra2",			gp_extra2,
			"gp_extra3",			gp_extra3,
			"gp_extra4",			gp_extra4,
			"gp_extra5",			gp_extra5,
			"gp_extra6",			gp_extra6,
			"gp_paddler",			gp_paddler,
			"gp_paddlel",			gp_paddlel,
			"gp_paddlerb",			gp_paddlerb,
			"gp_paddlelb",			gp_paddlelb,
			"gp_touchpadbutton",	gp_touchpadbutton

		);
	} catch(_) {
		__gmlspeak_log("New gamepad constants not available! Skipping...");		
	}
	
	#endregion
	#endregion
	#endregion
}