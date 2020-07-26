//Some commander logic variables
_inidbi = ["new", "BFM_OpforDetails"] call OO_INIDBI;
_result = (["read", ["opfor_settings", "opfor_commander_logic"]] call _inidbi);

if ((str _result) != "false") then {

} else {
	COMMANDER_PLAN = "NONE";
	COMMANDER_PLAN_RESOURCES = 0;
	COMMANDER_REINFORCE_PLAN_ID = 0;
	COMMANDER_PRESSURE = 0;		//Pressure is defined by the amount of objectives captured by bluefor. It affects reinforcing and counterattack
	COMMANDER_PATROL_COUNT = 0;
};


//Actual commander logic start
while {true} do {
	sleep 30;
	_rndPatrol = floor (random 100);
	_rndReinforce = floor (random 100);
	_rndCounterAttack = floor (random 100);

	if (!isNil "opfObjAreas_ACTIVE") then {
		if ((missionNamespace getVariable "opf_reservesRegularCount") >= 15) then {
			//Counterattack force needs at least 15 B1 Battledroids
			//Assemble help force
			_helpForce = [
				15,
				floor ((missionNamespace getVariable "opf_reservesEliteCount") /2),
				floor ((missionNamespace getVariable "opf_reservesTankCount") /2),
				floor ((missionNamespace getVariable "opf_reservesHeliCount") /2)
			];
			[_helpForce] remoteExec ["bfm_fnc_createHelpForce", 2, false];
		};
	} else if (COMMANDER_PLAN != "NONE") then {
		if (COMMANDER_PLAN_RESOURCES <= (missionNamespace getVariable "opf_reservesRegularCount")) then {
			switch (COMMANDER_PLAN) do {
				case "PATROL": {};
				case "REINFORCELOW": {};
				case "COUNTERATTACK": {};
				case "REINFORCESELECT": {};
				default { COMMANDER_PLAN = "NONE" };	//In case it's fucked up, we reset it
			};
		};
	} else if (COMMANDER_PATROL_COUNT < opfObjAreas_INACTIVE && _rndPatrol < 40) then {
		if ((missionNamespace getVariable "opf_reservesRegularCount") >= 8) then {
			[] remoteExec ["bfm_fnc_createCounterAttack", 2, false];
		} else {
			COMMANDER_PLAN = "PATROL";
		};
	} else if (_rndReinforce < 40) then {
		_obj = selectRandom opfObjAreas_INACTIVE;
		COMMANDER_REINFORCE_PLAN_ID = _obj#0;
		//We reinforce with AT LEAST 10 B1 Battledroids, and the others are random
		if ((missionNamespace getVariable "opf_reservesRegularCount") >= 10) then {
			_obj set [2, (_obj select 2)+10];
			missionNamespace setVariable ["opf_reservesRegularCount", (missionNamespace getVariable "opf_reservesRegularCount") - 10];
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
		} else {
			COMMANDER_PLAN = "REINFORCE";
		}
	} else if (_rndCounterAttack < 40) then {
		if ((missionNamespace getVariable "opf_reservesRegularCount") >= 20) then {
			//Help force needs at least 20 B1 Battledroids
			//Assemble help force
			_caForce = [
				20,
				floor ((missionNamespace getVariable "opf_reservesEliteCount") /2),
				floor ((missionNamespace getVariable "opf_reservesTankCount") /2),
				floor ((missionNamespace getVariable "opf_reservesHeliCount") /2)
			];
			[_caForce] remoteExec ["bfm_fnc_createCounterAttack", 2, false];
		} else {
			COMMANDER_PLAN = "COUNTERATTACK";
		}
	} else {
		{
			if ((_x select 2) < 20) then {
				COMMANDER_REINFORCE_PLAN_ID = _x#0;
				COMMANDER_PLAN = "REINFORCE";
			}
		} forEach opfObjAreas_INACTIVE;
	}
}

/*
missionNamespace getVariable "opf_reservesRegularCount"
missionNamespace getVariable "opf_reservesEliteCount"
missionNamespace getVariable "opf_reservesTankCount"
missionNamespace getVariable "opf_reservesHeliCount"
*/
