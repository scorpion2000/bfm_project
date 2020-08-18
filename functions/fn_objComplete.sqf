//Had to move this to the server, clients couldn't do this
params ["_obj"];

_o = missionNamespace getVariable _obj;
_o set [7, true];
missionNamespace setVariable [_obj, _o];