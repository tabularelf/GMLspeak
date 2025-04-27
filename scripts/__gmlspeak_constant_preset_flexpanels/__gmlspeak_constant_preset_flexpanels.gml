/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_flexpanels(){
	try {
		var _flexpanelUnit = {
			"point":			flexpanel_unit.point,	
			"percent":			flexpanel_unit.percent,	
			"auto":				flexpanel_unit.auto
		};
		
		var _flexpanelPositionType = {
			// GameMaker restricting static smh
			//"static":			flexpanel_position_type.static,	
			"relative":			flexpanel_position_type.relative,	
			"absolute":			flexpanel_position_type.absolute
		};
		
		var _flexpanelJustify = {
			"start":			flexpanel_justify.start,	
			"center":			flexpanel_justify.center,	
			"flex_end":			flexpanel_justify.flex_end,	
			"space_between":	flexpanel_justify.space_between,	
			"space_around":		flexpanel_justify.space_around,	
			"space_evenly":		flexpanel_justify.space_evenly,	
		};
		
		var _flexpanelDirection = {
			"inherit":			flexpanel_direction.inherit,
			"LTR":				flexpanel_direction.LTR,
			"RTL":				flexpanel_direction.RTL,
		};
		
		var _flexPanelGutter = {
			"column":			flexpanel_gutter.column,
			"row":				flexpanel_gutter.row,
			"all_gutters":		flexpanel_gutter.all_gutters,
		};
		
		var _flexpanelDisplay = {
			"flex":				flexpanel_display.flex,
			"none":				flexpanel_display.none
		};
		
		var _flexpanelFlexDirection = {
			"column":			flexpanel_flex_direction.column,
			"column_reverse":	flexpanel_flex_direction.column_reverse,
			"row":				flexpanel_flex_direction.row,
			"row_reverse":		flexpanel_flex_direction.row_reverse,
		};
		
		var _flexpanelAlign = {
			"auto":				flexpanel_align.auto,
			"flex_start":		flexpanel_align.flex_start,
			"center":			flexpanel_align.center,
			"flex_end":			flexpanel_align.flex_end,
			"stretch":			flexpanel_align.stretch,
			"baseline":			flexpanel_align.baseline,
			"space_between":	flexpanel_align.space_between,
			"space_around":		flexpanel_align.space_around,
			"space_evenly":		flexpanel_align.space_evenly,
		};
		
		var _flexpanelWrap = {
			"no_wrap":			flexpanel_wrap.no_wrap,
			"wrap":				flexpanel_wrap.wrap,
			"reverse":			flexpanel_wrap.reverse
		};
		
		var _flexpanelEdge = {
			"left":				flexpanel_edge.left,
			"top":				flexpanel_edge.top,
			"right":			flexpanel_edge.right,
			"bottom":			flexpanel_edge.bottom,
			"start":			flexpanel_edge.start,
			// GameMaker restricting end smh
			//"end":				flexpanel_edge.end,
			"horizontal":		flexpanel_edge.horizontal,
			"vertical":			flexpanel_edge.vertical,
			"all_edges":		flexpanel_edge.all_edges,
		};
		
		ffi.exposeConstant(
			"flexpanel_unit",			_flexpanelUnit,
			"flexpanel_position_type",	_flexpanelPositionType,
			"flexpanel_justify",		_flexpanelJustify,
			"flexpanel_direction",		_flexpanelDirection,
			"flexpanel_gutter",			_flexPanelGutter,
			"flexpanel_display",		_flexpanelDisplay,
			"flexpanel_flex_direction",	_flexpanelFlexDirection,
			"flexpanel_align",			_flexpanelAlign,
			"flexpanel_wrap",			_flexpanelWrap,
			"flexpanel_edge",			_flexpanelEdge
		);
	} catch(_) {
		__gmlspeak_log("Flexpanel constants not available! Skipping...");	
	}
}