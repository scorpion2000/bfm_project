/*
	Perhaps we could count the B1 droids in reserve, and base a randomization on that?
	Or we could get rid of the randomization overall?
*/

_rndReinforceHelp = floor (random 100);
_ctb = ((count (opfObjAreas_REINF) / count (opfObjAreas)) *100) -5;

//Maybe we could remove "opfObjAreas_REINF" from this if, and call this function only when it's not empty?
if (count (opfObjAreas_REINF) > 0 && _rndReinforceHelp >= _ctb) then { 
	if (DEBUG) then {systemChat "Opfor Commander Decision: Attempting To Send Reinforcements"};
	if ((missionNamespace getVariable "opf_reservesRegularCount") >= 15) then {
		//Reinforcement force needs at least 15 B1 Battledroids
		//Assemble reinforcements
		_obj = selectRandom opfObjAreas_REINF;

		if (isNil "BFM_HC1") then {
			[_obj] remoteExec ["bfm_fnc_createReinforcements", 2, false];
		} else {
			[_obj] remoteExec ["bfm_fnc_createReinforcements", BFM_HC1, false];
		};
		if (DEBUG) then {systemChat "Opfor Commander Decision: Creating Help Force"};
	}
};
