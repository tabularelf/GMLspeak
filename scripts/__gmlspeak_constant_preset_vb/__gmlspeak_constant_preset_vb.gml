/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_vb(ffi) {
	ffi.exposeConstant(
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
	
	ffi.exposeConstant(
		"pr_pointlist", pr_pointlist,
		"pr_linelist", pr_linelist,
		"pr_linestrip", pr_linestrip,
		"pr_trianglelist", pr_trianglelist,
		"pr_trianglestrip", pr_trianglestrip,
		"pr_trianglefan", pr_trianglefan
	);
}