/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_audio(ffi) {
	ffi.exposeConstant( 
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
	
	#region Audio Bus & Effects
		static __AudioEffectTypeStruct = {};	
		static __AudioLFOType = {};
		try {
			__AudioLFOType.InvSawtooth = AudioLFOType.InvSawtooth;
			__AudioLFOType.Sawtooth = AudioLFOType.Sawtooth;
			__AudioLFOType.Sine = AudioLFOType.Sine;
			__AudioLFOType.Square = AudioLFOType.Square;
			__AudioLFOType.Triangle = AudioLFOType.Triangle;
			
			ffi.exposeConstant( 
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
			
			ffi.exposeConstant( 
				"AudioEffectType", __AudioEffectTypeStruct,
				"audio_bus_main", audio_bus_main
			);
		} catch(_) {
			__gmlspeak_log("Audio Bus & Effects are unavailable! Skipping...");
		}
		#endregion
}