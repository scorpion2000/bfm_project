_inidbi = ["new", "BFM_ObjectiveDetails"] call OO_INIDBI;
_emptyCheck = (["read", ["objective_settings", "objective_0"]] call _inidbi);

if ((str _emptyCheck) != "false") then {
	for "_i" from 0 to 6 do {
		_result = (["read", ["objective_settings", format ["objective_%1", _i]]] call _inidbi);
		missionNamespace setVariable [format ["objective_%1", _i], _result];
	};
} else {
	[] execVM "scripts\initOpforCommander.sqf";
}