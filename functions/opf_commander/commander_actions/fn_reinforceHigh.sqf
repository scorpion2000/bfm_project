/*
	Commander should start with this
	Create a limit for what counts as "low", ~50 should be enough
	If there's no "low" objectives, the commander randomly reinforces an area
	Better than randomly deciding if it should reinforce a low objective
	
	Note: Maybe we could create a reinforceHigh function? The Commander could prioritize making a few objectives REALLY hardcore
	Maybe objectives that are worth a lot? Anyways, need to rework how the commander gets its reinforcements for that, so it can decide
	which objectives are worth a lot
*/
if (DEBUG) then {systemChat "Opfor Commander Decision: Planning To Reinforce Weakest Objective"};
_high = 0;
_obj = [];
{
	_tmp = missionNamespace getVariable (_x select 0);
	if ((_tmp select 2) > _high) then {
		_high = (_tmp select 2);
		_obj = missionNamespace getVariable (_x select 0);
	}
} forEach opfObjAreas;
//We reinforce with AT LEAST 10 B1 Battledroids, and the others are random
if ((missionNamespace getVariable "opf_reservesRegularCount") >= _rndReinforceCount) then {
	if (DEBUG) then {systemChat "Opfor Commander Decision: Reinforcing Objective"};
	_obj set [2, (_obj select 2)+_rndReinforceCount];
	missionNamespace setVariable ["opf_reservesRegularCount", (missionNamespace getVariable "opf_reservesRegularCount") - _rndReinforceCount];
	_rndElite = floor (random (missionNamespace getVariable "opf_reservesEliteCount"));
	_obj set [3, (_obj select 3)+_rndElite];
	missionNamespace setVariable ["opf_reservesEliteCount", (missionNamespace getVariable "opf_reservesEliteCount") - _rndElite];
	_rndTank = floor (random (missionNamespace getVariable "opf_reservesTankCount"));
	_obj set [4, (_obj select 4)+_rndTank];
	missionNamespace setVariable ["opf_reservesTankCount", (missionNamespace getVariable "opf_reservesTankCount") - _rndTank];
	_rndHeli = floor (random (missionNamespace getVariable "opf_reservesHeliCount"));
	_obj set [5, (_obj select 5)+_rndHeli];
	missionNamespace setVariable ["opf_reservesHeliCount", (missionNamespace getVariable "opf_reservesHeliCount") - _rndHeli];
	[] remoteExec ["bfm_fnc_saveObjectiveDetails", 2, false];
};
