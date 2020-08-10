params ["_veh"];

waitUntil { isTouchingGround _veh };

sleep 1;

{
	moveOut _x;
	unassignVehicle _x;
	sleep 0.25;
} forEach assignedCargo _veh;

sleep 1;

_veh land "CANCEL";
_wp = group (driver _veh) addWaypoint [getPos reinfDelZone, 0];
_wp setWaypointType "MOVE";

waitUntil { _veh inArea reinfDelZone };

{_veh deleteVehicleCrew _x} forEach crew _veh;
deleteVehicle _veh;
