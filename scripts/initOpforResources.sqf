if (DEBUG) then { systemChat "Creating Opfor Commander Details" };

missionNamespace setVariable ["opf_reservesRegularCount", 10];	//Regular B1
missionNamespace setVariable ["opf_reservesEliteCount", 5];	//BX-Series Commando Droid
missionNamespace setVariable ["opf_reservesTankCount", 2];		//Mainly AAT, can be MTT
missionNamespace setVariable ["opf_reservesHeliCount", 1];		//Mainly attack gunships, can be carriers

reinf_timer = 50;	//Frequency with which OPFOR gets reinforcements

[] remoteExec ["bfm_fnc_handleReinforcements", 2, false];
[] remoteExec ["bfm_fnc_saveOpforDetails", 2, false];
