if (count opfObjAreas_EXCESS > 1) then {
	if (DEBUG) then {systemChat "Redistributing B1 Battledroids to weakest objective"};

	//Get weakest objective
	_low = 100;
	_weakSelect = "objective_0";
	for "_i" from 0 to 6 do {
		_o = missionNamespace getVariable format ["objective_%1", _i];
		if ((_o select 2) < _low) then {
			_low = (_o select 2);
			_weakSelect = format ["objective_%1", _i];
		};
	};

	_strongSelect = selectRandom opfObjAreas_EXCESS;
	_strong = missionNamespace getVariable _strongSelect;
	_weak = missionNamespace getVariable _weakSelect;

	_B1Count = floor (random (_strong select 2) -50);

	_strong set [2, (_strong select 2) - _B1Count];
	_weak set [2, (_weak select 2) + _B1Count];
	missionNamespace setVariable [_strongSelect, _strong];
	missionNamespace setVariable [_weakSelect, _weak];
};