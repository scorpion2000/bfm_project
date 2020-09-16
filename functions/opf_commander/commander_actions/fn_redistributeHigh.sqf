/*
	Same as redistribute, but this moves units from any objective to one big objetive. This big objective is based on which objective has the most units,
	giving a bit of randomness to the mission.
	
	The commander only does this under REALLY HIGH pressure. Basically a last resort
*/

if (count opfObjAreas_EXCESS > 1) then {
	if (DEBUG) then {systemChat "Redistributing B1 Battledroids to weakest objective"};

	//Get strongest objective
	_high = 0;
	_weakSelect = "objective_0";
	for "_i" from 0 to (count opfObjAreas) do {
		_o = missionNamespace getVariable format ["objective_%1", _i];
		if ((_o select 2) > _high) then {
			_high = (_o select 2);
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