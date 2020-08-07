params ["_objective", "_spawnArea", "_triggerArea"];

if (DEBUG) then {systemChat "Spawn Complete, Moving Area To Active"};

/*	I'm pretty fucking sure inAreaArray does not fucking work	*/
/*	Update: It may be working, and checkObjectivesForBlufor.sqf is just sending in other active areas for no reason	*/

{
	if (_x getVariable "obj" == _objective) then {
		deleteVehicle _x;
		sleep 0.05;
	}
} forEach allUnits inAreaArray _triggerArea;

{
	if (_x getVariable "obj" == _objective && (typeOf _x == "ls_hmp" || typeOf _x == "ls_aat")) then {
		_veh = _x;
		{ _veh deleteVehicleCrew _x } forEach crew _x;
		deleteVehicle _veh;
		sleep 0.05;
	}
} forEach vehicles inAreaArray _triggerArea;

//We should also check all remaining units, just in case some escaped the trigger area
{
	if (_x getVariable "obj" == _objective) then {
		deleteVehicle _x;
		sleep 0.05;
	}
} forEach allUnits;

{
	if (_x getVariable "obj" == _objective && (typeOf _x == "ls_hmp" || typeOf _x == "ls_aat")) then {
		_veh = _x;
		{ _veh deleteVehicleCrew _x } forEach crew _x;
		deleteVehicle _veh;
		sleep 0.05;
	}
} forEach vehicles;

if (DEBUG) then {systemChat format ["Despawn Complete, Moving %1 To Inactive", _objective]};

opfObjAreas_WORKING = opfObjAreas_WORKING - [_triggerArea];
opfObjAreas_INACTIVE pushBack _triggerArea;
