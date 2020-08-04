//Some commander logic variables
_inidbi = ["new", "BFM_OpforDetails"] call OO_INIDBI;
_result = (["read", ["opfor_commander", "opfor_commander_logic_variables"]] call _inidbi);

if ((str _result) != "false") then {
	COMMANDER_PLAN = _result#0;
	COMMANDER_REINFORCE_PLAN_ID = _result#1;
	COMMANDER_PRESSURE = _result#2;
	COMMANDER_PATROL_COUNT = _result#3;
} else {
	COMMANDER_PLAN = "NONE";
	COMMANDER_REINFORCE_PLAN_ID = 0;
	COMMANDER_PRESSURE = 0;		//Pressure is defined by the amount of objectives captured by bluefor. It affects reinforcing and counterattack
	COMMANDER_PATROL_COUNT = 0;
};

if (DEBUG) then {systemChat "Opfor Commander Initialized"};

_opf_objs = [
	"objective_0",
	"objective_1",
	"objective_2",
	"objective_3",
	"objective_4",
	"objective_5",
	"objective_6"
];

//Actual commander logic start
while {true} do {
	sleep 45;	//Not sure how often this should update. 45s seems reasonable?
	_rndPatrol = floor (random 100);
	_rndReinforce = floor (random 100);
	_rndCounterAttack = floor (random 100);
	_rndReinforceLow = floor (random 100);
	_rndReinforceCount = floor (random 10);

	switch (true) do {
		case (count (opfObjAreas_ACTIVE) > 0 && COMMANDER_PLAN == "NONE"): { 
			if (DEBUG) then {systemChat "Opfor Commander Decision: Attempting Help Force Creation"};
			if ((missionNamespace getVariable "opf_reservesRegularCount") >= 20) then {
				//Counterattack force needs at least 15 B1 Battledroids
				//Assemble help force
				_helpForce = [
					15,
					floor ((missionNamespace getVariable "opf_reservesEliteCount") /2),
					floor ((missionNamespace getVariable "opf_reservesTankCount") /2),
					floor ((missionNamespace getVariable "opf_reservesHeliCount") /2)
				];
				if (isNil "BFM_HC1") then {
					[_helpForce] remoteExec ["bfm_fnc_createHelpForce", 2, false];
				} else {
					[_helpForce] remoteExec ["bfm_fnc_createHelpForce", BFM_HC1, false];
				};
				if (DEBUG) then {systemChat "Opfor Commander Decision: Creating Help Force"};
			} else {
				COMMANDER_PLAN = "HELP";
			};
		};
		case (COMMANDER_PLAN != "NONE"): { 
			switch (COMMANDER_PLAN) do {
				case "PATROL": {
					if (DEBUG) then {systemChat "Opfor Commander Decision: Reattempting Patrol Creation"};
					if ((missionNamespace getVariable "opf_reservesRegularCount") >= 8) then {
						if (isNil "BFM_HC1") then {
							[] remoteExec ["bfm_fnc_createPatrol", 2, false];
						} else {
							[] remoteExec ["bfm_fnc_createPatrol", BFM_HC1, false];
						}
					}  else {
						COMMANDER_PLAN = "NONE";
					};
				};
				case "HELP": {
					if (DEBUG) then {systemChat "Opfor Commander Decision: Reattempting Help Force Creation"};
					if (!isNil "opfObjAreas_ACTIVE") then {
						if ((missionNamespace getVariable "opf_reservesRegularCount") >= 15) then {
							if (isNil "BFM_HC1") then {
								[] remoteExec ["bfm_fnc_createHelpForce", 2, false];
							} else {
								[] remoteExec ["bfm_fnc_createHelpForce", BFM_HC1, false];
							}
						}  else {
							COMMANDER_PLAN = "HELP";
						};
					} else {
						COMMANDER_PLAN = "NONE";
					};
				};
				case "COUNTERATTACK": {
					if (DEBUG) then {systemChat "Opfor Commander Decision: Reattempting Counterattack Creation"};
					if ((missionNamespace getVariable "opf_reservesRegularCount") >= 20) then {
						//Help force needs at least 20 B1 Battledroids
						//Assemble help force
						_caForce = [
							20,
							floor (random (missionNamespace getVariable "opf_reservesEliteCount")),
							floor (random (missionNamespace getVariable "opf_reservesTankCount")),
							floor (random (missionNamespace getVariable "opf_reservesHeliCount"))
						];
						if (isNil "BFM_HC1") then {
							[] remoteExec ["bfm_fnc_createCounterAttack", 2, false];
						} else {
							[] remoteExec ["bfm_fnc_createCounterAttack", BFM_HC1, false];
						}
					} else {
						COMMANDER_PLAN = "NONE";
					}
				};
				case "REINFORCE": {
					if (DEBUG) then {systemChat format ["Opfor Commander Decision: Reattempting Reinforcing Objective %1", COMMANDER_REINFORCE_PLAN_ID]};
					if ((missionNamespace getVariable "opf_reservesRegularCount") >= _rndReinforceCount) then {
						_obj = [];
						_objName = "";
						{
							_tmp = missionNamespace getVariable _x;
							if ((_tmp select 0) == COMMANDER_REINFORCE_PLAN_ID) then {
								_obj = missionNamespace getVariable _x;
								_objName = _x;
							};
						} forEach _opf_objs;
						_obj set [2, ((_obj select 2)+_rndReinforceCount)];
						missionNamespace setVariable ["opf_reservesRegularCount", (missionNamespace getVariable "opf_reservesRegularCount") - _rndReinforceCount];
						_rndElite = floor (random (missionNamespace getVariable "opf_reservesEliteCount"));
						_obj set [3, ((_obj select 3)+_rndElite)];
						missionNamespace setVariable ["opf_reservesEliteCount", (missionNamespace getVariable "opf_reservesEliteCount") - _rndElite];
						_rndTank = floor (random (missionNamespace getVariable "opf_reservesTankCount"));
						_obj set [4, ((_obj select 4)+_rndTank)];
						missionNamespace setVariable ["opf_reservesTankCount", (missionNamespace getVariable "opf_reservesTankCount") - _rndTank];
						_rndHeli = floor (random (missionNamespace getVariable "opf_reservesHeliCount"));
						_obj set [5, ((_obj select 5)+_rndHeli)];
						missionNamespace setVariable ["opf_reservesHeliCount", (missionNamespace getVariable "opf_reservesHeliCount") - _rndHeli];
						missionNamespace setVariable [_objName, _obj];
						[] remoteExec ["bfm_fnc_saveObjectiveDetails", 2, false];
						[] remoteExec ["bfm_fnc_saveOpforDetails", 2, false];
					} else {
						COMMANDER_PLAN = "NONE";
					}
				};
				default { COMMANDER_PLAN = "NONE" };	//In case it's fucked up, we reset it
			};
		};
		case (COMMANDER_PATROL_COUNT < count (opfObjAreas_INACTIVE) && _rndPatrol < 30): { 
			if (DEBUG) then {systemChat "Opfor Commander Decision: Attempting Patrol Creation"};
			if ((missionNamespace getVariable "opf_reservesRegularCount") >= 8) then {
				if (isNil "BFM_HC1") then {
					[] remoteExec ["bfm_fnc_createPatrol", 2, false];
				} else {
					[] remoteExec ["bfm_fnc_createPatrol", BFM_HC1, false];
				}
			} else {
				COMMANDER_PLAN = "PATROL";
			};
		};
		case (_rndReinforce < 40): {
			if (DEBUG) then {systemChat "Opfor Commander Decision: Attempting Reinforcement"};
			_obj = selectRandom _opf_objs;
			_obj = missionNamespace getVariable _obj;
			COMMANDER_REINFORCE_PLAN_ID = (_obj select 0);
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
			} else {
				COMMANDER_PLAN = "REINFORCE";
			}
		};
		case (_rndCounterAttack < 10): { 
			if (DEBUG) then {systemChat "Opfor Commander Decision: Attempting Counterattack"};
			if ((missionNamespace getVariable "opf_reservesRegularCount") >= 20) then {
				//Help force needs at least 20 B1 Battledroids
				//Assemble help force
				_caForce = [
					20,
					floor (random (missionNamespace getVariable "opf_reservesEliteCount")),
					floor (random (missionNamespace getVariable "opf_reservesTankCount")),
					floor (random (missionNamespace getVariable "opf_reservesHeliCount"))
				];
				if (isNil "BFM_HC1") then {
					[] remoteExec ["bfm_fnc_createCounterAttack", 2, false];
				} else {
					[] remoteExec ["bfm_fnc_createCounterAttack", BFM_HC1, false];
				}
			} else {
				COMMANDER_PLAN = "COUNTERATTACK";
			}
		};
		case (_rndReinforceLow < 50): {
			if (DEBUG) then {systemChat "Opfor Commander Decision: Planning To Reinforce Weakest Objective"};
			_low = 100;
			{
				_tmp = missionNamespace getVariable _x;
				if ((_tmp select 2) < _low) then {
					_low = (_tmp select 2);
					COMMANDER_REINFORCE_PLAN_ID = (_tmp select 0);
					COMMANDER_PLAN = "REINFORCE";
				}
			} forEach _opf_objs;
		};
		default {
			if (DEBUG) then {systemChat "Opfor Commander Decision: Waiting For More Resources"};
			//Do something here, maybe?
		};
	};
	_saveArray = [
		COMMANDER_PLAN,
		COMMANDER_REINFORCE_PLAN_ID,
		COMMANDER_PRESSURE,
		COMMANDER_PATROL_COUNT
	];
	["write", ["opfor_settings", "opfor_commander_logic_variables", _saveArray]] call _inidbi;
}
