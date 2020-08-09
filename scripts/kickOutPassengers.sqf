params ["_veh"];

waitUntil { isTouchingGround _veh };

{
	moveOut _x;
	unassignVehicle _x;
} forEach assignedCargo _veh;

_veh land "CANCEL";
_wp = group (driver _veh) addWaypoint [getPos reinfDelZone, 0];
_wp setWaypointType "MOVE";

waitUntil { _veh inArea reinfDelZone };

{_veh deleteVehicleCrew _x} forEach crew _veh;
deleteVehicle _veh;
