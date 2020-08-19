_inidbi = ["new", "BFM_OpforDetails"] call OO_INIDBI;
_keysArray = ["getKeys", "opfor_patrols"] call _inidbi;

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

{
	_result = (["read", ["opfor_patrols", _x]] call _inidbi);
	["deleteKey", ["opfor_patrols", _x]] call _inidbi;

	if ((_result select 0) > 0) then {
		_b1c = _result#0;

		_sl = createGroup [east, true] createUnit ["ls_cis_oomOfficer_standard", (_result select 2), [], 0, "CAN_COLLIDE"];
		_sl setVariable ["patrolTo", str (_sl)];
		_sl addEventHandler ["Killed", {
			_o = missionNamespace getVariable (((_this select 0) getVariable "patrolTo"));
			_c = ((missionNamespace getVariable (((_this select 0) getVariable "patrolTo")) select 0))-1;
			_o set [0, _c];
			missionNamespace setVariable [(_this select 0) getVariable "patrolTo", _o];
		}];
		sleep 0.1;
		for "_i" from 1 to (_b1c -1) do {
			_unit = group _sl createUnit [selectRandom _B1UnitTypes, (_result select 2), [], 0, "CAN_COLLIDE"];
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

		{
			_wp = group _sl addWaypoint [_x, 0];
			_wp setWaypointType "MOVE";
			_wayPoints pushBack _x;
			sleep 0.1;
		} forEach (_result select 1);
		_wp = group _sl addWaypoint [getPosATL _sl, 0];
		_wp setWaypointType "CYCLE";

		group _sl setSpeedMode "LIMITED";
		group _sl setBehaviour "SAFE";
		sleep 0.1;

		missionNamespace setVariable [(str _sl), [_b1c, _wayPoints, getPos _sl]];
		[(str _sl), _sl] remoteExec ["bfm_fnc_savePatrol", 2, false];
	} else {
		COMMANDER_PATROL_COUNT = COMMANDER_PATROL_COUNT -1;
	};
} forEach _keysArray;