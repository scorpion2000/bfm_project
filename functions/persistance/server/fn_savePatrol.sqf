params ["_patrolName"];

_inidbi = ["new", "BFM_OpforDetails"] call OO_INIDBI;
["write", ["opfor_patrols", _patrolName, missionNamespace getVariable _patrolName]] call _inidbi;
