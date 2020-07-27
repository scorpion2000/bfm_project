DEBUG = TRUE;	//Enables systemChat debug messages

sleep 1;

[] execVM "scripts\playerSave.sqf";
[] execVM "scripts\serverPerfMeter.sqf";

//Load all necessary server settings from database
[] remoteExec ["bfm_fnc_loadObjectiveDetails", 2, false];
[] remoteExec ["bfm_fnc_loadOpforDetails", 2, false];
sleep 3;
[] remoteExec ["bfm_fnc_opforCommanderLogic", 2, false];