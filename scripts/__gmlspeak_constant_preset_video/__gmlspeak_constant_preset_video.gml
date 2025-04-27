/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_video(ffi) {
	ffi.exposeConstant( 
		"video_format_rgba",		video_format_rgba,
		"video_format_yuv",			video_format_yuv,
		"video_status_closed",		video_status_closed,
		"video_status_preparing",	video_status_preparing,
		"video_status_playing",		video_status_playing,
		"video_status_paused",		video_status_paused
	);
}