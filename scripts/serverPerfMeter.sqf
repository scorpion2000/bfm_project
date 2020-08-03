_avgPerfMrk = createMarker ["avgPerfMrk", [4,4092.05,0.000839233]];

while {true} do {
	sleep 1.5;

	"avgPerfMrk" setMarkerType "mil_dot";
	"avgPerfMrk" setMarkerText format ["Server Performance: %1fps", diag_fps];
}
