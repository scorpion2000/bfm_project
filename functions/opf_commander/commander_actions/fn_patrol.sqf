if (COMMANDER_PATROL_COUNT < count (opfObjAreas_INACTIVE) && _rndPatrol < 30) then { 
	if (DEBUG) then {systemChat "Opfor Commander Decision: Attempting Patrol Creation"};
	if ((missionNamespace getVariable "opf_reservesRegularCount") >= 8) then {
		if (isNil "BFM_HC1") then {
			[] remoteExec ["bfm_fnc_createPatrol", 2, false];
		} else {
			[] remoteExec ["bfm_fnc_createPatrol", BFM_HC1, false];
		};
		COMMANDER_PATROL_COUNT = COMMANDER_PATROL_COUNT +1;
	};
};