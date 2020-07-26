opfObjAreas_INACTIVE = [
	spawnTriggerArea_obj_1,
	spawnTriggerArea_obj_2,
	spawnTriggerArea_obj_3,
	spawnTriggerArea_obj_4,
	spawnTriggerArea_obj_5,
	spawnTriggerArea_obj_6,
	spawnTriggerArea_obj_7
];

opfObjAreas_ACTIVE = [

];

opfObjAreas_WORKING = [

];

while {true} do {
	{
		"areaCheckMarker" setMarkerPos (getPos _x);
		if (count(allPlayers inAreaArray _x) > 0) then {
			opfObjAreas_INACTIVE = opfObjAreas_INACTIVE - [_x];
			opfObjAreas_ACTIVE pushBack _x;
			//Move to WORKING list and spawn
		};
		sleep 0.2;
	} forEach opfObjAreas_INACTIVE;
	if (!isNil "opfObjAreas_ACTIVE") then {
		{
			"areaCheckMarker2" setMarkerPos (getPos _x);
			if (count(allPlayers inAreaArray _x) == 0) then {
				opfObjAreas_ACTIVE = opfObjAreas_ACTIVE - [_x];
				opfObjAreas_INACTIVE pushBack _x;
				//Move to WORKING list and despawn
			};
			sleep 0.2;
		} forEach opfObjAreas_ACTIVE;
	}
}
