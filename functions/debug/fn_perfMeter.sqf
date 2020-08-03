/*	Now compatible with all clients. Map will now display the plyer's, the server's and the HC's FPS	*/

//Server
if (isDedicated) then {
	_avgPerfMrk = createMarker ["avgPerfMrk", [4,4092.05,0.000839233]];

	while {true} do {
		sleep 1.5;

		"avgPerfMrk" setMarkerType "mil_dot";
		"avgPerfMrk" setMarkerText format ["Server Performance: %1fps", diag_fps];
	};
};

//HC
if (!hasInterface && !isServer) then {
	_avgPerfMrk = createMarker ["avgPerfMrk2", [4,4092.05,6.000839233]];

	while {true} do {
		sleep 1.5;

		"avgPerfMrk2" setMarkerType "mil_dot";
		"avgPerfMrk2" setMarkerText format ["Server Performance: %1fps", diag_fps];
	};
};

//Client
if (hasInterface && !isServer) then {
	_avgPerfMrk = createMarker ["avgPerfMrk3", [4,4092.05,12.000839233]];

	while {true} do {
		sleep 1.5;

		"avgPerfMrk3" setMarkerType "mil_dot";
		"avgPerfMrk3" setMarkerText format ["Server Performance: %1fps", diag_fps];
	};
};
