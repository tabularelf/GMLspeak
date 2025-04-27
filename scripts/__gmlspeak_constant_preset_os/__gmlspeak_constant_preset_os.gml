/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_os(ffi) {
	ffi.exposeConstant( 
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
	
	ffi.exposeDynamicConstant( 
		"os_browser", function() {return os_browser;},
		"os_version", function() {return os_version;},
		"os_device", function() {return os_device;},
		// This technically doesn't need to be dynamic but just in case...
		"os_type", function() {return os_type;}
	);
}