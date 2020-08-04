opfObjAreas = [
	["objective_0", spawnTriggerArea_obj_1],
	["objective_1", spawnTriggerArea_obj_2],
	["objective_2", spawnTriggerArea_obj_3],
	["objective_3", spawnTriggerArea_obj_4],
	["objective_4", spawnTriggerArea_obj_5],
	["objective_5", spawnTriggerArea_obj_6],
	["objective_6", spawnTriggerArea_obj_7]
];

opfObjAreas_INACTIVE = [];
opfObjAreas_ACTIVE = [];
opfObjAreas_WORKING = [];

{
	if !(((missionNamespace getVariable (_x select 0)) select 6)) then {
		opfObjAreas_INACTIVE pushBack (_x select 1);
	}
} forEach opfObjAreas;

while {true} do {
	{
		"areaCheckMarker" setMarkerPos (getPos _x);
		if (count(allPlayers inAreaArray _x) > 0) then {
			opfObjAreas_INACTIVE = opfObjAreas_INACTIVE - [_x];
			opfObjAreas_WORKING pushBack _x;
			_obj = _x;
			{
				if (_obj == (_x select 1)) then {
					_obj = (_x select 0);
				}
			} forEach opfObjAreas;

			//Move to WORKING list and spawn
			if (isNil "BFM_HC1") then {
				[_obj] remoteExec ["bfm_fnc_createObjForce", 2, false];
			} else {
				[_obj] remoteExec ["bfm_fnc_createObjForce", BFM_HC1, false];
			};
		};
		sleep 0.2;
	} forEach opfObjAreas_INACTIVE;
	if (!isNil "opfObjAreas_ACTIVE") then {
		{
			"areaCheckMarker2" setMarkerPos (getPos _x);
			if (count(allPlayers inAreaArray _x) == 0) then {
				opfObjAreas_ACTIVE = opfObjAreas_ACTIVE - [_x];
				opfObjAreas_WORKING pushBack _x;
				_obj = _x;
				{
					if (_obj == (_x select 1)) then {
						_obj = (_x select 0);
					}
				} forEach opfObjAreas;

				//Move to WORKING list and spawn
				if (isNil "BFM_HC1") then {
					//[_obj] remoteExec ["bfm_fnc_createObjForce", 2, false];
				} else {
					//[_obj] remoteExec ["bfm_fnc_createObjForce", BFM_HC1, false];
				};
			};
			sleep 0.2;
		} forEach opfObjAreas_ACTIVE;
	}
}
