_b1c = missionNamespace getVariable "opf_reservesRegularCount";
_b1c = ceil (_b1c / 2);
if (_b1c > 8) then {
	_b1c = floor random (_b1c -8) +8;
};

_B1UnitTypes = [
	"ls_cis_b1_standard",		//Some classnames appear multiple times to influence selection chance
	"ls_cis_b1_standard",
	"ls_cis_b1_standard",
	"ls_cis_b1_standard",
	"ls_cis_b1_standard",
	"ls_cis_b1_standard",
	"ls_cis_b1_standard",
	"ls_cis_b1_standard",
	"ls_cis_b1AtMissile_standard",
	"ls_cis_b1AtMissile_standard",
	"ls_cis_b1AaMissile_standard",
	"ls_cis_b1AaMissile_standard",
	"ls_cis_b1AaMissile_standard",
	"ls_cis_b1Grenadier_standard",
	"ls_cis_b1Heavy_standard",
	"ls_cis_b1Heavy_standard",
	"ls_cis_b1Heavy_standard",
	"ls_cis_b1Heavy_standard",
	"ls_cis_b1Heavy_standard",
	"ls_cis_b1Marksman_standard",
	"ls_cis_b1Marksman_standard"
];

//Patrol hardcap
if (_b1c > 14) then {
	_b1c = 14;
};

missionNamespace setVariable ["opf_reservesRegularCount", ((missionNamespace getVariable "opf_reservesRegularCount") - _b1c)];

_locations = [];

{
	_locations pushBack (_x select 2);
} forEach opfObjAreas;

_l = selectRandom _locations;

_posRnd = _l call BIS_fnc_randomPosTrigger;
_safePos = [_posRnd, 0, 100] call BIS_fnc_findSafePos;
_locations = _locations - [_l];

_sl = createGroup [east, true] createUnit ["ls_cis_oomOfficer_standard", _l, [], 0, "CAN_COLLIDE"];
_sl setVariable ["patrolTo", str (_sl)];
_sl addEventHandler ["Killed", {
	_o = missionNamespace getVariable (((_this select 0) getVariable "patrolTo"));
	_c = ((missionNamespace getVariable (((_this select 0) getVariable "patrolTo")) select 0))-1;
	_o set [0, _c];
	missionNamespace setVariable [(_this select 0) getVariable "patrolTo", _o];
}];
sleep 0.1;
for "_i" from 1 to (_b1c -1) do {
	_unit = group _sl createUnit [selectRandom _B1UnitTypes, _l, [], 0, "CAN_COLLIDE"];
	_unit setVariable ["patrolTo", str (_sl)];
	_unit addEventHandler ["Killed", {
		_o = missionNamespace getVariable (((_this select 0) getVariable "patrolTo"));
		_c = ((missionNamespace getVariable (((_this select 0) getVariable "patrolTo")) select 0))-1;
		_o set [0, _c];
		missionNamespace setVariable [(_this select 0) getVariable "patrolTo", _o];
	}];
	sleep 0.1;
};

_wayPoints = [];

for "_i" from 1 to (floor (random 2) +2) do {	//+2, we don't want 0 waypoints, and we want more than 1 so they actually move back and forth
	_l = selectRandom _locations;
	_posRnd = _l call BIS_fnc_randomPosTrigger;
	_safePos = [_posRnd, 0, 100] call BIS_fnc_findSafePos;
	_locations = _locations - [_l];
	_wayPoints pushBack _safePos;
	_wp = group _sl addWaypoint [_safePos, 0];
	_wp setWaypointType "MOVE";
	sleep 0.1;
};
_wp = group _sl addWaypoint [getPosATL _sl, 0];
_wp setWaypointType "CYCLE";

group _sl setSpeedMode "LIMITED";
group _sl setBehaviour "SAFE";
sleep 0.1;

missionNamespace setVariable [str _sl, [_b1c, _wayPoints, getPos _sl]];

[(str _sl), _sl] remoteExec ["bfm_fnc_savePatrol", 2, false];
