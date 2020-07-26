_inidbi = ["new", "BFM_ObjectiveDetails"] call OO_INIDBI;
_emptyCheck = (["read", ["OPFOR_settings", "OPFOR_Commander_Details"]] call _inidbi);

if ((str _emptyCheck) != "false") then {
	_result = (["read", ["objective_settings", format ["objective_%1", _i]]] call _inidbi);
	missionNamespace setVariable [format ["objective_%1", _i], _result];
} else {
	[] execVM "scripts\initOpforSettings.sqf";
}