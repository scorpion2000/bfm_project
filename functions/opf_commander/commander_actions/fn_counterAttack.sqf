/*	
	This should be more than just a random selection
	In the meantime, nothing is actually calling this function
*/

_rndCounterAttack = floor (random 100);

if (_rndCounterAttack < 5) then { 
	if (DEBUG) then {systemChat "Opfor Commander Decision: Attempting Counterattack"};
	if ((missionNamespace getVariable "opf_reservesRegularCount") >= 20) then {
		//Help force needs at least 20 B1 Battledroids
		//Assemble help force
		_caForce = [
			20,
			floor (random (missionNamespace getVariable "opf_reservesEliteCount")),
			floor (random (missionNamespace getVariable "opf_reservesTankCount")),
			floor (random (missionNamespace getVariable "opf_reservesHeliCount"))
		];
		if (isNil "BFM_HC1") then {
			[] remoteExec ["bfm_fnc_createCounterAttack", 2, false];
		} else {
			[] remoteExec ["bfm_fnc_createCounterAttack", BFM_HC1, false];
		}
	} else {
		COMMANDER_PLAN = "COUNTERATTACK";
	}
};