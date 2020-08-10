//This script checks if players have selected a class before they can be deployed
{
	if (_x getVariable ["playerClass", ""] != "") then {
		//This is probably the only script that is remote executed on client side lol
		[_x] remoteExec ["bfm_fnc_deployPlayer", _x, false];
	}
} forEach allPlayers in tpTrigger;
