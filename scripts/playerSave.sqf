while {true} do {
	//Making a save every 30 seconds
	//Note, we also make a save on disconnects. This is in case the server crashes
	sleep 30;
	
	{
		[_x] remoteExec ["bfm_fnc_savePlayerStats", 2, false];
	} forEach allPlayers;
};