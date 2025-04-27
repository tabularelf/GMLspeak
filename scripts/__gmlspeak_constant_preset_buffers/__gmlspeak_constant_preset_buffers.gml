/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_buffers(ffi) {
	ffi.exposeConstant(
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
	
	#region Buffer Error Constants
	try {
		ffi.exposeConstant(
			"buffer_error_general", buffer_error_general,
			"buffer_error_out_of_space", buffer_error_out_of_space,
			"buffer_error_invalid_type", buffer_error_invalid_type,
		);
	} catch(_) {
		__gmlspeak_log("Buffer error constants not available! Skipping...");		
	}
	#endregion
}