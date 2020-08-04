DEBUG = TRUE;	//Enables systemChat debug messages

sleep 1;

[] execVM "scripts\playerSave.sqf";

//Load all necessary server settings from database
[] remoteExec ["bfm_fnc_loadObjectiveDetails", 2, false];
[] remoteExec ["bfm_fnc_loadOpforDetails", 2, false];
sleep 3;
[] remoteExec ["bfm_fnc_opforCommanderLogic", 2, false];
[] remoteExec ["bfm_fnc_loadPatrols", 2, false];

//Prepairing HC Connection
addMissionEventHandler ["HandleDisconnect",
{
	//params ["_unit", "_id", "_uid", "_name"];
	[(_this select 0)] remoteExec ["bfm_fnc_savePlayerStats", 2, false];
	false;
}];
