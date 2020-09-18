while {true} do {
	//Making a save every 7.5 seconds
	//Note, we also make a save on disconnects. This is in case the server crashes
	sleep 7.5;
	
	{
		[_x] remoteExec ["bfm_fnc_savePlayerStats", 2, false];
	} forEach allPlayers;
};