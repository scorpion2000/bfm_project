enableEnvironment [false, false];

[
	laat_console, 
	"<t color='#03bf00'>Create LAAT</t>", 
	"img\createIcon.paa", 
	"img\createIcon.paa", 
	"_this distance _target < 3", 
	"_caller distance _target < 3", 
	{ hint "Creating..." }, 
	{}, 
	{ hint "Complete!"; [] remoteExec ["BFM_fnc_laatSpawnBase", 2, false]; }, 
	{ hint "Cancelled!" }, 
	[], 
	2, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;

[
	warthog_console, 
	"<t color='#03bf00'>Create Warthog Transport</t>", 
	"img\createIcon.paa", 
	"img\createIcon.paa", 
	"_this distance _target < 3", 
	"_caller distance _target < 3", 
	{ hint "Creating..." }, 
	{}, 
	{ hint "Complete!"; [] remoteExec ["BFM_fnc_warthogSpawnBase", 2, false]; }, 
	{ hint "Cancelled!" }, 
	[], 
	2, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;

[
	obj_1_baseConsole, 
	"<t color='#03bf00'>Lower Base Shields</t>", 
	"img\createIcon.paa", 
	"img\createIcon.paa", 
	"_this distance _target < 3", 
	"_caller distance _target < 3", 
	{ hint "Lowering Shields..." }, 
	{ }, 
	{ 
		hint "Shields Lowered!"; 
		deleteVehicle obj_1_shield;
		_n = "OPTRE_RS_ConsoleCorvette_SysRed" createVehicle [0,0,0];
		_n setDir (getDir obj_1_baseConsole);
		_n setPosATL (getPosATL obj_1_baseConsole);
		deleteVehicle obj_1_baseConsole;
	}, 
	{ hint "Cancelled!" }, 
	[], 
	10, 
	nil, 
	true, 
	false
] call BIS_fnc_holdActionAdd;

[
	obj_1_artilleryConsole, 
	"<t color='#03bf00'>Disable Long Range Artillery</t>", 
	"img\createIcon.paa", 
	"img\createIcon.paa", 
	"_this distance _target < 3", 
	"_caller distance _target < 3", 
	{ hint "Disabling Long Range Artillery..." }, 
	{}, 
	{
		hint "Long Range Artillery Disabled!";
		_n = "OPTRE_RS_ConsoleCorvette_SysRed" createVehicle [0,0,0];
		_n setDir (getDir obj_1_artilleryConsole);
		_n setPosATL (getPosATL obj_1_artilleryConsole);
		deleteVehicle obj_1_artilleryConsole;
		_o = missionNamespace getVariable "objective_1";
		_o set [7, true];
		missionNamespace setVariable ["objective_1", _o];
	}, 
	{ hint "Cancelled!" }, 
	[], 
	10, 
	nil, 
	true, 
	false
] call BIS_fnc_holdActionAdd;

sleep 1;
[player] remoteExec ["bfm_fnc_loadPlayerStats", 2, false];
