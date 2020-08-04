_inidbi = ["new", "BFM_OpforDetails"] call OO_INIDBI;
_keysArray = ["getKeys", "opfor_patrols"] call _inidbi;

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

{
	_result = (["read", ["opfor_patrols", _x]] call _inidbi);
	["deleteKey", ["opfor_patrols", _x]] call _inidbi;

	_sl = createGroup [east, true] createUnit ["SWLB_b1_officer_base", (_result select 2), [], 0, "CAN_COLLIDE"];
	_sl setVariable ["patrolTo", str (_sl)];
	_sl addEventHandler ["Killed", {
		missionNamespace setVariable [(_this select 0) getVariable "patrolTo", ((missionNamespace getVariable ((_this select 0) getVariable "patrolTo")) select 0)-1];
	}];
	sleep 0.1;
	for "_i" from 1 to (floor (random 6) +2) do {
		_unit = group _sl createUnit [selectRandom _B1UnitTypes, (_result select 2), [], 0, "CAN_COLLIDE"];
		_unit setVariable ["patrolTo", str (_sl)];
		_unit addEventHandler ["Killed", {
			missionNamespace setVariable [(_this select 0) getVariable "patrolTo", ((missionNamespace getVariable ((_this select 0) getVariable "patrolTo")) select 0)-1];
		}];
		sleep 0.1;
	};

	_wayPoints = [];

	{
		_wp = group _sl addWaypoint [_x, 0];
		_wp setWaypointType "MOVE";
		sleep 0.1;
	} forEach (_result select 1);
	_wp = group _sl addWaypoint [getPosATL _sl, 0];
	_wayPoints pushBack getPosATL _sl;
	_wp setWaypointType "CYCLE";

	group _sl setSpeedMode "LIMITED";
	group _sl setBehaviour "SAFE";
	sleep 0.1;

	missionNamespace setVariable [(_result select 0), [_b1c, _wayPoints, getPos _sl]];
	[(_result select 0)] remoteExec ["bfm_fnc_savePatrol", 2, false];
} forEach _keysArray;