/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_sequences(ffi) {
	ffi.exposeConstant( 
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
}