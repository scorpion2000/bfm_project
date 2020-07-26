_inidbi = ["new", "BFM_OpforDetails"] call OO_INIDBI;
_result = (["read", ["OPFOR_settings", "opfor_resource_details"]] call _inidbi);

if ((str _result) != "false") then {
	if (DEBUG) then { systemChat "Loading Opfor Commander Details From Database" };
	missionNamespace setVariable ["opf_reservesRegularCount", _result select 0];
	missionNamespace setVariable ["opf_reservesEliteCount", _result select 1];
	missionNamespace setVariable ["opf_reservesTankCount", _result select 2];
	missionNamespace setVariable ["opf_reservesHeliCount", _result select 3];
	reinf_timer = _result select 4;

	[] remoteExec ["bfm_fnc_handleReinforcements", 2, false];
} else {
	if (DEBUG) then { systemChat "Opfor Commander Details Not Found In Database" };
	[] execVM "scripts\initOpforResources.sqf";
}
