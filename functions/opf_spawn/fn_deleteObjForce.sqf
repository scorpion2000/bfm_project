params ["_objective", "_spawnArea", "_triggerArea"];

if (DEBUG) then {systemChat "Spawn Complete, Moving Area To Active"};

/*	I'm pretty fucking sure inAreaArray does not fucking work	*/

{
	if (_x inArea _triggerArea) then {
		deleteVehicle _x;
		sleep 0.05;
	}
} forEach allUnits inAreaArray _triggerArea;

{
	if (_x inArea _triggerArea && (typeOf _x == "ls_hmp" || typeOf _x == "ls_aat")) then {
		deleteVehicle _x;
		sleep 0.05;
	}
} forEach vehicles inAreaArray _triggerArea;

if (DEBUG) then {systemChat "Depawn Complete, Moving Area To Inactive"};

opfObjAreas_WORKING = opfObjAreas_WORKING - [_triggerArea];
opfObjAreas_INACTIVE pushBack _triggerArea;
