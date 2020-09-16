if (((missionNamespace getVariable "opf_reservesRegularCount") /2) >= 20) then {
	if (DEBUG) then {systemChat "Opfor Commander Decision: Attempting Reinforcement"};
	_objCheck = true;
	_obj = "";
	_objCheckLimit = 10;	//Hardcoded runtime limit, so the commander won't get stuck in this at the very last objective
	while {_objCheck && _objCheckLimit > 0} do {
		_obj = selectRandom opfObjAreas;
		if ((_obj select 1) in opfObjAreas_INACTIVE) then {
			_objCheck = false;
		};
		_objCheckLimit = _objCheckLimit -1;
	};
	_obj = (_obj select 0);
	if (!_objCheck) then {
		_obj = missionNamespace getVariable _obj;
		//We reinforce with AT LEAST 10 B1 Battledroids, and the others are random
		if ((missionNamespace getVariable "opf_reservesRegularCount") >= _rndReinforceCount) then {
			if (DEBUG) then {systemChat "Opfor Commander Decision: Reinforcing Objective"};
			_obj set [2, (_obj select 2)+_rndReinforceCount];
			missionNamespace setVariable ["opf_reservesRegularCount", (missionNamespace getVariable "opf_reservesRegularCount") - _rndReinforceCount];
			_rndElite = floor (random (missionNamespace getVariable "opf_reservesEliteCount"));
			_obj set [3, (_obj select 3)+_rndElite];
			missionNamespace setVariable ["opf_reservesEliteCount", (missionNamespace getVariable "opf_reservesEliteCount") - _rndElite];
			_rndTank = floor (random (missionNamespace getVariable "opf_reservesTankCount"));
			_obj set [4, (_obj select 4)+_rndTank];
			missionNamespace setVariable ["opf_reservesTankCount", (missionNamespace getVariable "opf_reservesTankCount") - _rndTank];
			_rndHeli = floor (random (missionNamespace getVariable "opf_reservesHeliCount"));
			_obj set [5, (_obj select 5)+_rndHeli];
			missionNamespace setVariable ["opf_reservesHeliCount", (missionNamespace getVariable "opf_reservesHeliCount") - _rndHeli];
			[] remoteExec ["bfm_fnc_saveObjectiveDetails", 2, false];
		};
	};
};