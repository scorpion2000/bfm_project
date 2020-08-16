_spawnPos = [[842,142,0], [835.5,122.5,0], [859,127,0]];
_i = 0;
_badSpawn = true;
_p = selectRandom _spawnPos;

while {_badSpawn && _i < 5} do {
	if (count (nearestObjects [_p, ["OPTRE_M813_TT"], 5]) > 0) then {
		_badSpawn = true;
		_p = selectRandom _spawnPos;
	} else {
		_badSpawn = false;
	};
	_i = _i +1;
	sleep 1;
	if (DEBUG) then { systemChat str _badSpawn };
};

if !(_badSpawn) then {
	_laat = createVehicle ["OPTRE_M813_TT", [0,0,0], [], 0, "CAN_COLLIDE"];
	_laat setDir 90;
	_laat setPosATL _p;
};