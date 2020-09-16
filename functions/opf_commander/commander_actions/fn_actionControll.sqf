/*
	This function could controll which actions the commander wants to take
	May not need this, however, it could give a finer controll to the commander's logic

	LIST OF AVAILABLE ACTIONS:
	WAITING (just increases reserves)
	bfm_fnc_counterArrack
	bfm_fnc_createReinforcement
	bfm_fnc_patrol
	bfm_fnc_redistribute
	bfm_fnc_redistributeHigh
	bfm_fnc_reinforce
	bfm_fnc_reinforceLow
	bfm_fnc_reinforceHigh
*/

ACTION_ARRAY = [];	//We're holding all actions the commander wants to do in this array

//Commander has different chances for actions under different pressure levels
//Note: bfm_fnc_createReinforcement is in this array at all times. That action does it's own calculations
while {true} do {
	ACTION_ARRAY pushBack "bfm_fnc_createReinforcement";
	switch (true) do {
		case (COMMANDER_PRESSURE < 20): {
			//Puts down a few units every now and then, but generally keeps units in reserves
			if (random 100 < 80) then {ACTION_ARRAY pushBack "WAITING"} else {
				if (random 100 < 40) then {ACTION_ARRAY pushBack "bfm_fnc_patrol"};
				if (random 100 < 20) then {ACTION_ARRAY pushBack "bfm_fnc_reinforce"};
			};
		};
		case (COMMANDER_PRESSURE < 40): {
			//Acknowledge hostile existance, but doesn't care too much about it
			if (random 100 < 60) then {ACTION_ARRAY pushBack "WAITING"} else {
				if (random 100 < 75) then {ACTION_ARRAY pushBack "bfm_fnc_patrol"};
				if (random 100 < 75) then {ACTION_ARRAY pushBack "bfm_fnc_reinforce"};
			};
		};
		//Waiting is not an option at this point
		case (COMMANDER_PRESSURE < 60): {
			//Hostile threat is getting bad, and the commander wants to prepare for a fight
			if (random 100 < 40) then {ACTION_ARRAY pushBack "bfm_fnc_reinforceLow"};
			if (random 100 < 50) then {ACTION_ARRAY pushBack "bfm_fnc_patrol"};
			if (random 100 < 60) then {ACTION_ARRAY pushBack "bfm_fnc_redistribute"};
		};
		case (COMMANDER_PRESSURE < 80): {
			//Hostiles are stronger than expected, and the commander wants to go all out
			if (random 100 < 60) then {ACTION_ARRAY pushBack "bfm_fnc_reinforceLow"};
			if (random 100 < 80) then {ACTION_ARRAY pushBack "bfm_fnc_patrol"};
			if (random 100 < 60) then {ACTION_ARRAY pushBack "bfm_fnc_redistribute"};
		};
		case (COMMANDER_PRESSURE < 100): {
			//Hostiles are winning. Commander goes all in on an objective and basically turtles it
			if (random 100 < 60) then {ACTION_ARRAY pushBack "bfm_fnc_reinforceHigh"};
			if (random 100 < 80) then {ACTION_ARRAY pushBack "bfm_fnc_patrol"};
			if (random 100 < 90) then {ACTION_ARRAY pushBack "bfm_fnc_redistributeHigh"};
		};
		default {};
	};
	[] remoteExec ["bfm_fnc_runActions", 2, false];
	[] remoteExec ["bfm_fnc_calcPressure", 2, false];
	sleep 60;
};