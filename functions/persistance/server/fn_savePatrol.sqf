params ["_patrolName", "_slUnit"];

_inidbi = ["new", "BFM_OpforDetails"] call OO_INIDBI;

while {true} do {
	_p = missionNamespace getVariable _patrolName;
	_p set [2, getPos _slUnit];
	missionNamespace setVariable [_patrolName, _p];
	["write", ["opfor_patrols", _patrolName, missionNamespace getVariable _patrolName]] call _inidbi;
	sleep 10;
};
