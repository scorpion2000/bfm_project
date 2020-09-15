if (DEBUG) then { systemChat "Starting Opfor Reinforcement Handle" };

/*
	This needs a rework
	Each objective should contribute to how much reinforcements the commander should get
	This whole randomization can still be useful though, for construction resources?
*/

while {true} do {
	sleep reinf_timer;
	if (count allPlayers > 0) then {
		_rnd = floor (random 100);
		switch (true) do {
			case (_rnd < 60): {
				//B1 Battledroid
				missionNamespace setVariable ["opf_reservesRegularCount", ((missionNamespace getVariable "opf_reservesRegularCount") + (floor (random 5) +1))];
				if (DEBUG) then { systemChat "Creating Reinforcements For Opfor Commander; Type Regular" };
			};
			case (_rnd >= 60 && _rnd < 80): {
				//BX-Series Commando Droid
				missionNamespace setVariable ["opf_reservesEliteCount", ((missionNamespace getVariable "opf_reservesEliteCount") + (floor (random 2) +1))];
				if (DEBUG) then { systemChat "Creating Reinforcements For Opfor Commander; Type Elite" };
			};
			case (_rnd >= 80 && _rnd < 95): {
				//Tank
				missionNamespace setVariable ["opf_reservesTankCount", ((missionNamespace getVariable "opf_reservesTankCount") + (floor (random 1) +1))];
				if (DEBUG) then { systemChat "Creating Reinforcements For Opfor Commander; Type Tank" };
			};
			case (_rnd >= 95): {
				//Gunship
				missionNamespace setVariable ["opf_reservesHeliCount", ((missionNamespace getVariable "opf_reservesHeliCount") + (floor (random 1) +1))];
				if (DEBUG) then { systemChat "Creating Reinforcements For Opfor Commander; Type Heli" };
			};
			default {
				//Default (which should not happen) is B1 Battledroid
				missionNamespace setVariable ["opf_reservesRegularCount", ((missionNamespace getVariable "opf_reservesRegularCount") + (floor (random 5) +1))];
				if (DEBUG) then { systemChat "Creating Reinforcements For Opfor Commander; Type B1" };
			};
		};
	};
	[] remoteExec ["bfm_fnc_saveOpforDetails", 2, false];
};
