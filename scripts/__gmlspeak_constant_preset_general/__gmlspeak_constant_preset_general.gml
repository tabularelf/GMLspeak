/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_general(ffi) {
	ffi.exposeConstant( 
			"gamespeed_fps",					gamespeed_fps,
			"tm_countvsyncs",					tm_countvsyncs,
			"tm_sleep",							tm_sleep,
			"gamespeed_microseconds",			gamespeed_microseconds,
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
		
		ffi.exposeDynamicConstant( 
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
			"program_directory", function() {return program_directory;},
			"temp_directory",	function() {return temp_directory;},
			"working_directory", function() {return working_directory;},
			"game_save_id",		function() {return game_save_id;},
			"game_project_name", function() {return game_project_name;},
			"game_project_name", function() {return game_project_name;},
			"game_display_name", function() {return game_display_name;},
			"cursor_sprite",	 function() {return cursor_sprite;},
			"display_aa",		 function() {return display_aa;}
		);
		
		// Non-LTS
		
		#region Timings 
		try {
			ffi.exposeConstant( 
				"tm_systemtiming",		tm_systemtiming
			);
		} catch(_) {
			__gmlspeak_log("tm_systemtiming not available! Skipping...");	
		}
		#endregion
		
		#region Sandbox value 
		try {
			ffi.exposeDynamicConstant( 
				"GM_is_sandboxed",		function() {return GM_is_sandboxed;}
			);
		} catch(_) {
			__gmlspeak_log("GM_is_sandboxed not available! Skipping...");	
		}
		#endregion
		
			#region GM_runtime_type
		try {
			var _value = GM_runtime_type;
			ffi.exposeDynamicConstant(
				"GM_runtime_type", function() {return GM_runtime_type;}
			);
		} catch(_) {
			__gmlspeak_log("GM_runtime_type not available! Skipping...");		
		}
		
		#region Wallpaper specific
		try {
			ffi.exposeConstant(
				"wallpaper_config", wallpaper_config
			);
		} catch(_) {
			__gmlspeak_log("Wallpaper specific constants not available... Skipping!");	
			}
		#endregion
}