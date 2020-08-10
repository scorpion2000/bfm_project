params ["_patrolName", "_slUnit"];

_inidbi = ["new", "BFM_OpforDetails"] call OO_INIDBI;
_p = missionNamespace getVariable _patrolName;

while {(_p select 0) > 0} do {
	_p set [2, getPos _slUnit];
	missionNamespace setVariable [_patrolName, _p];
	["write", ["opfor_patrols", _patrolName, missionNamespace getVariable _patrolName]] call _inidbi;
	sleep 10;
};

if ((_p select 0) <= 0) then {
	["deleteKey", ["opfor_patrols", _patrolName]] call _inidbi;
	COMMANDER_PATROL_COUNT = COMMANDER_PATROL_COUNT -1;
};
