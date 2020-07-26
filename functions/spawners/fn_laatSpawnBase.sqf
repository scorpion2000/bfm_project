_spawnPos = [823.47,213.812,3.62955];
_i = 0;
_badSpawn = true;

while {_badSpawn && _i < 5} do {
	if (count (nearestObjects [_spawnPos, ["ls_laat_ab"], 23]) > 0) then {
		_badSpawn = true;
	} else {
		_badSpawn = false;
	};
	_i = _i +1;
	sleep 1;
	if (DEBUG) then { systemChat str _badSpawn };
};

if !(_badSpawn) then {
	_laat = createVehicle ["ls_laat_ab", [0,0,0], [], 0, "CAN_COLLIDE"];
	_laat setDir 90;
	_laat setPosATL _spawnPos;
};