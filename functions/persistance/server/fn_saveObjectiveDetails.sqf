_inidbi = ["new", "BFM_OpforDetails"] call OO_INIDBI;

for "_i" from 0 to 6 do {
	_saveArray = missionNamespace getVariable format ["objective_%1", _i];
	["write", ["objective_settings", format ["objective_%1", _i], _saveArray]] call _inidbi;
};
