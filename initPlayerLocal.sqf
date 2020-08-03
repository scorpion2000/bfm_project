enableEnvironment [false, false];
//This is kinda stupid, but there's no proper way to call a function
//This is literally TELLING the SERVER to execut it for THIS CLIENT. Stupid.
[] remoteExec ["bfm_fnc_perfMeter", player, false];

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

sleep 1;
[player] remoteExec ["bfm_fnc_loadPlayerStats", 2, false];
