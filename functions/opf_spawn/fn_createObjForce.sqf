params ["_objective", "_spawnArea", "_triggerArea"];

/*
	FORMAT
		ID
		Name
		Regular B1 Count
		BX-Series Commando Droids
		Tanks
		Gunships
		Checks if the objective is in Blufor hands or not
*/
_obj = missionNamespace getVariable _objective;

if (DEBUG) then {systemChat format ["Spawning AI at %1", _obj#1]};

_B1UnitTypes = [
	"SWLB_b1_base",		//Some classnames appear multiple times to influence selection chance
	"SWLB_b1_base",
	"SWLB_b1_base",
	"SWLB_b1_base",
	"SWLB_b1_base",
	"SWLB_b1_at_base",
	"SWLB_b1_AA_base",
	"SWLB_b1_AA_base",
	"SWLB_b1_grenadier_base",
	"SWLB_b1_heavy_base",
	"SWLB_b1_heavy_base",
	"SWLB_b1_heavy_base",
	"SWLB_b1_marksman_base"
];
_milBuildingList = [];

{
	_allBuildingPos = [_x] call BIS_fnc_buildingPositions;
	_cfg = configFile >> "CfgVehicles" >> typeOf _x; 
	_EdenCat = getText( _cfg >> "editorCategory" ); 
	_EdenSubCat = getText( _cfg >> "editorSubcategory" ); 
	
	if !( _EdenCat isEqualTo "" ) then { 
		_EdenCat = getText( configFile >> "CfgEditorCategories" >> _EdenCat >> "displayName" ); 
	}; 
	
	if !( _EdenSubCat isEqualTo "" ) then { 
		_EdenSubCat = getText( configFile >> "CfgEditorSubCategories" >> _EdenSubCat >> "displayName" ); 
	};

	if (_EdenSubCat == "Military" && count _allBuildingPos != 0) then {
		_milBuildingList pushBack _x;
	};
} forEach nearestObjects [_spawnArea, ["Building", "House"], 350];


//Calculates how many droids to spawn inside buildings
//It generally takes half the B1s, but it gets reduced with low applicable building count
_stationaryB1 = floor ((_obj select 2) /2);
_unitsToFill = count _milBuildingList * 3;	//Calculates with 3 units per building
if (_unitsToFill <= _stationaryB1) then { _stationaryB1 = _unitsToFill };
_obj set [2, ((_obj select 2) - _stationaryB1)];
_rem = _obj#2;

//Create B1 droids inside buildings
if (_obj#2 != 0 && count _milBuildingList > 0) then {
	_grp = createGroup [east, true];
	for "_i" from 1 to _stationaryB1 do {
		_pos = [];
		_badSpawn = true;
		while {_badSpawn} do {
			_b = selectRandom _milBuildingList;
			_allBuildingPos = [_b] call BIS_fnc_buildingPositions;
			_pos = selectRandom _allBuildingPos;

			if (count (nearestObjects [_pos, ["Man","Car","Tank"], 4]) > 0) then {
				_badSpawn = true;
			} else {
				_badSpawn = false;
			};
		};
		_unit = _grp createUnit [selectRandom _B1UnitTypes, _pos, [], 0, "CAN_COLLIDE"];
		_unit setVariable ["obj", _objective];
		_unit addEventHandler ["Killed", {
			_o = missionNamespace getVariable ((_this select 0) getVariable "obj");
			_o set [2, ((_obj select 2) -1)];
			missionNamespace setVariable [((_this select 0) getVariable "obj"), _o];
		}];
		_unit disableAI "PATH";
		_unit setUnitPos "UP";
		_unit setDir random 360;
		sleep 0.1;
	};
};

while {_rem > 0} do {		//3 man squad, minimum
	_posRnd = _spawnArea call BIS_fnc_randomPosTrigger;
	_safePos = [_posRnd, 0, 100] call BIS_fnc_findSafePos;
	
	_sl = createGroup [east, true] createUnit ["SWLB_b1_officer_base", _safePos, [], 0, "CAN_COLLIDE"];
	_sl setVariable ["obj", _objective];
	_sl addEventHandler ["Killed", {
		_o = missionNamespace getVariable ((_this select 0) getVariable "obj");
		_o set [2, ((_obj select 2) -1)];
		missionNamespace setVariable [((_this select 0) getVariable "obj"), _o];
	}];
	_rem = _rem -1;
	sleep 0.1;
	for "_i" from 1 to (floor (random 6) +2) do {
		if (_rem > 0) then {	//Gotta make sure we don't spawn more than we have
			_unit = group _sl createUnit [selectRandom _B1UnitTypes, _safePos, [], 0, "CAN_COLLIDE"];
			_unit setVariable ["obj", _objective];
			_unit addEventHandler ["Killed", {
				_o = missionNamespace getVariable ((_this select 0) getVariable "obj");
				_o set [2, ((_obj select 2) -1)];
				missionNamespace setVariable [((_this select 0) getVariable "obj"), _o];
			}];
			_rem = _rem -1;
			sleep 0.1;
		};
	};

	for "_i" from 1 to (floor (random 4) +2) do {	//+2, we don't want 0 waypoints, and we want more than 1 so they actually move back and forth
		_posRnd = _spawnArea call BIS_fnc_randomPosTrigger;
		_safePos = [_posRnd, 0, 100] call BIS_fnc_findSafePos;
		_wp = group _sl addWaypoint [_safePos, 0];
		_wp setWaypointType "MOVE";
		sleep 0.1;
	};
	_wp = group _sl addWaypoint [getPosATL _sl, 0];
	_wp setWaypointType "CYCLE";

	group _sl setSpeedMode "LIMITED";
	group _sl setBehaviour "SAFE";
};
//_obj set [2, ((_obj select 2) + _patrolB1)];	//We add back leftovers, if any

//Spawn in tanks, if any
if (_obj#4 != 0) then {
	for "_i" from 1 to _obj#4 do {
		_posRnd = _spawnArea call BIS_fnc_randomPosTrigger;
		_safePos = _posRnd findEmptyPosition [10, 350, "ls_aat"];

		_tank = createVehicle ["ls_aat", [_safePos#0, _safePos#1, 2], [], 0, "NONE"]; //Should be "NONE", in case the safe spot is too close to something
		_tank setVariable ["obj", _objective];
		_tank addEventHandler ["Killed", {
			_o = missionNamespace getVariable ((_this select 0) getVariable "obj");
			_o set [4, ((_obj select 4) -1)];
			missionNamespace setVariable [((_this select 0) getVariable "obj"), _o];
		}];
		createVehicleCrew _tank;
		_tank setDir random 360;
		sleep 0.1;
	};
};


//Spawn in gunships, if any
if (_obj#5 != 0) then {
	for "_i" from 1 to _obj#5 do {
		_posRnd = _spawnArea call BIS_fnc_randomPosTrigger;
		_safePos = [_posRnd#0, _posRnd#1, 60];	//Makes spawn pos in air

		_gs = createVehicle ["ls_hmp", _safePos, [], 0, "FLY"]; //Should be "NONE", in case the safe spot is too close to something
		_gs setVariable ["obj", _objective];
		_gs addEventHandler ["Killed", {
			_o = missionNamespace getVariable ((_this select 0) getVariable "obj");
			_o set [5, ((_obj select 5) -1)];
			missionNamespace setVariable [((_this select 0) getVariable "obj"), _o];
		}];
		createVehicleCrew _gs;
		_wp = group _gs addWaypoint [_posRnd, 0];
		_wp setWaypointType "HOLD";
		_gs setDir random 360;
		sleep 0.1;
	};
};

//Spawn Commando Droids, if any
if (_obj#3 != 0) then {
	for "_i" from 1 to _obj#3 do {
		//Randomization. 0 = patrol, else these droids (try) to occupy military buildings
		if (floor (random 1) == 0) then {
			_posRnd = _spawnArea call BIS_fnc_randomPosTrigger;
			_safePos = [_posRnd, 0, 100] call BIS_fnc_findSafePos;
			
			_unit = createGroup [east, true] createUnit [selectRandom ["SWLB_BX_Commando", "SWLB_BX_Commando", "SWLB_BX_Commando", "SWLB_BX_Assassin"], _safePos, [], 0, "CAN_COLLIDE"];
			_unit setVariable ["obj", _objective];
			_unit addEventHandler ["Killed", {
				_o = missionNamespace getVariable ((_this select 0) getVariable "obj");
				_o set [3, ((_obj select 3) -1)];
				missionNamespace setVariable [((_this select 0) getVariable "obj"), _o];
			}];
			sleep 0.1;

			for "_i" from 1 to (floor (random 4) +2) do {	//+2, we don't want 0 waypoints, and we want more than 1 so they actually move back and forth
				_posRnd = _spawnArea call BIS_fnc_randomPosTrigger;
				_safePos = [_posRnd, 0, 100] call BIS_fnc_findSafePos;
				_wp = group _unit addWaypoint [_safePos, 0];
				_wp setWaypointType "MOVE";
				sleep 0.1;
			};
			_wp = group _unit addWaypoint [getPosATL _unit, 0];
			_wp setWaypointType "CYCLE";

			group _unit setSpeedMode "LIMITED";
			group _unit setBehaviour "SAFE";
			sleep 0.1;
		} else {
			_pos = [];
			_badSpawn = true;
			while {_badSpawn} do {
				_b = selectRandom _milBuildingList;
				_allBuildingPos = [_b] call BIS_fnc_buildingPositions;
				_pos = selectRandom _allBuildingPos;

				if (count (nearestObjects [_pos, ["Man","Car","Tank"], 4]) > 0) then {
					_badSpawn = true;
				} else {
					_badSpawn = false;
				};
			};
			_unit = createGroup [east, true] createUnit [selectRandom ["SWLB_BX_Commando", "SWLB_BX_Commando", "SWLB_BX_Commando", "SWLB_BX_Assassin"], _pos, [], 0, "CAN_COLLIDE"];
			_unit setVariable ["obj", _objective];
			_unit addEventHandler ["Killed", {
				_o = missionNamespace getVariable ((_this select 0) getVariable "obj");
				_o set [3, ((_obj select 3) -1)];
				missionNamespace setVariable [((_this select 0) getVariable "obj"), _o];
			}];
			_unit disableAI "PATH";
			_unit setUnitPos "UP";
			_unit setDir random 360;
			sleep 0.1;
		};
	};
};

if (DEBUG) then {systemChat "Spawn Complete, Moving Area To Active"};

opfObjAreas_WORKING = opfObjAreas_WORKING - [_triggerArea];
opfObjAreas_ACTIVE pushBack _triggerArea;
