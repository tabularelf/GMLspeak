/// feather ignore all
/// @ignore
function __gmlspeak_constant_preset_networking(ffi) {
	ffi.exposeConstant( 
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
}