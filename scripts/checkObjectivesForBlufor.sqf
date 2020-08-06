opfObjAreas = [
	["objective_0", spawnTriggerArea_obj_1, area_obj_1],
	["objective_1", spawnTriggerArea_obj_2, area_obj_2],
	["objective_2", spawnTriggerArea_obj_3, area_obj_3],
	["objective_3", spawnTriggerArea_obj_4, area_obj_4],
	["objective_4", spawnTriggerArea_obj_5, area_obj_5],
	["objective_5", spawnTriggerArea_obj_6, area_obj_6],
	["objective_6", spawnTriggerArea_obj_7, area_obj_7]
];

opfObjAreas_INACTIVE = [];
opfObjAreas_ACTIVE = [];
opfObjAreas_WORKING = [];
activeObjLimit = 3;		//Note: That's the amount that can be active at once

{
	if !(((missionNamespace getVariable (_x select 0)) select 6)) then {
		opfObjAreas_INACTIVE pushBack (_x select 1);
	}
} forEach opfObjAreas;

while {true} do {
	{
		"areaCheckMarker" setMarkerPos (getPos _x);
		if (!isNil "opfObjAreas_INACTIVE" && count(allPlayers inAreaArray _x) > 0 && (count opfObjAreas_ACTIVE) < activeObjLimit && (count opfObjAreas_WORKING) == 0) then {
			opfObjAreas_INACTIVE = opfObjAreas_INACTIVE - [_x];
			opfObjAreas_WORKING pushBack _x;
			_area = area_obj_1;
			_obj = _x;
			{
				if (str (_obj) == str (_x select 1)) then {
					_obj = (_x select 0);
					_area = (_x select 2);
				}
			} forEach opfObjAreas;

			//Move to WORKING list and spawn
			if (isNil "BFM_HC1") then {
				[_obj, _area, _x] remoteExec ["bfm_fnc_createObjForce", 2, false];
			} else {
				[_obj, _area, _x] remoteExec ["bfm_fnc_createObjForce", BFM_HC1, false];
			};
		};
		sleep 0.2;
	} forEach opfObjAreas_INACTIVE;
	if (!isNil "opfObjAreas_ACTIVE") then {
		{
			"areaCheckMarker2" setMarkerPos (getPos _x);
			if (count (allPlayers inAreaArray _x) < 1 && (count opfObjAreas_WORKING) == 0) then {
				opfObjAreas_ACTIVE = opfObjAreas_ACTIVE - [_x];
				opfObjAreas_WORKING pushBack _x;
				_area = area_obj_1;
				_obj = _x;
				{
					if (str (_obj) == str (_x select 1)) then {
						_obj = (_x select 0);
						_area = (_x select 2);
					}
				} forEach opfObjAreas;

				//Move to WORKING list and despawn
				if (isNil "BFM_HC1") then {
					[_obj, _area, _x] remoteExec ["bfm_fnc_deleteObjForce", 2, false];
				} else {
					[_obj, _area, _x] remoteExec ["bfm_fnc_deleteObjForce", BFM_HC1, false];
				};
			};
			sleep 0.15;
		} forEach opfObjAreas_ACTIVE;
	}
}
