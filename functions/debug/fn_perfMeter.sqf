/*	Now compatible with all clients. Map will now display the plyer's, the server's and the HC's FPS	*/
//Server
if (isDedicated) then {
	_avgPerfMrk = createMarker ["avgPerfMrk", [4,4092.05,0.000839233]];
	if (DEBUG) then {systemChat "Creating Server Performance Monitor"};
	"avgPerfMrk" setMarkerType "mil_dot";

	while {true} do {
		sleep 1.5;
		"avgPerfMrk" setMarkerText format ["Server Performance: %1fps", diag_fps];
	};
};

//HC
if (!hasInterface && !isServer) then {
	_avgPerfMrk = createMarker ["avgPerfMrk2", [4,3992.05,0.000839233]];
	if (DEBUG) then {systemChat "Creating HC Performance Monitor"};
	"avgPerfMrk2" setMarkerType "mil_dot";

	while {true} do {
		sleep 1.5;
		"avgPerfMrk2" setMarkerText format ["HC Performance: %1fps", diag_fps];
	};
};

//Client
if (hasInterface && !isServer) then {
	//Clients have a local marker
	_avgPerfMrk = createMarkerLocal ["avgPerfMrk3", [4,3892.05,0.000839233]];
	if (DEBUG) then {systemChat "Creating Client Performance Monitor"};
	"avgPerfMrk3" setMarkerType "mil_dot";

	while {true} do {
		sleep 1.5;
		"avgPerfMrk3" setMarkerText format ["Client Performance: %1fps", diag_fps];
	};
};

//Client Server (hosted from editor, for example)
if (hasInterface && isServer) then {
	_avgPerfMrk = createMarker ["avgPerfMrk4", [4,3792.05,0.000839233]];
	if (DEBUG) then {systemChat "Creating Local Performance Monitor"};
	"avgPerfMrk4" setMarkerType "mil_dot";

	while {true} do {
		sleep 1.5;
		"avgPerfMrk4" setMarkerText format ["Local Performance: %1fps", diag_fps];
	};
};
