params ["_objName"];

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

_obj = [];
{
	if ((_x select 0) == _objName) then {
		_obj = _x;
	}
} forEach opfObjAreas;

//Amount of B1 droids the script will work with
_B1count = (floor (random floor (((missionNamespace getVariable "opf_reservesRegularCount") -15) /2))) +15;
systemChat format ["Using %1 B1 Battledroids As Reinforcements", _B1count];
missionNamespace setVariable ["opf_reservesRegularCount", (missionNamespace getVariable "opf_reservesRegularCount") - _B1count];

while {_B1count > 0} do {
	_posRnd = (_obj select 2) call BIS_fnc_randomPosTrigger;
	_safePos = [_posRnd#0, _posRnd#1, (floor (random 500) +1000)];	//Makes spawn pos high up in air
	_gs = createVehicle ["442_hmp_transport", _safePos, [], 0, "CAN_COLLIDE"]; //Should be "NONE", in case the safe spot is too close to something
	_driverGroup = createVehicleCrew _gs;
	_driverGroup setBehaviour "CARELESS";
	_sl = createGroup [east, true] createUnit ["ls_cis_oomOfficer_standard", _safePos, [], 0, "CAN_COLLIDE"];
	_sl setVariable ["obj", _objName];
	_unit setVariable ["reserve", true];
	_sl moveInAny _gs;
	_B1count = _B1count -1;
	for "_i" from 1 to 8 do {
		if (_B1count > 0) then {
			_unit = group _sl createUnit [selectRandom _B1UnitTypes, _safePos, [], 0, "CAN_COLLIDE"];
			_unit setVariable ["obj", _objName];
			_unit setVariable ["reserve", true];
			_unit moveInAny _gs;
			_B1count = _B1count -1;
		}
	};
	_gs land "GET OUT";
	[_gs] execVM "scripts\kickOutPassengers.sqf";
};
