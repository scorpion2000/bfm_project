while {true} do {
	sleep reinf_timer;
	if (count allPlayers > 0) then {
		_rnd = floor (random 100);
		switch (true) do {
			case (_rnd < 60): {
				//B1 Battledroid
				missionNamespace setVariable ["opf_reservesRegularCount", (missionNamespace getVariable "opf_reservesRegularCount" + (floor (random 5) +1))];
			};
			case (_rnd >= 60 && _rnd < 80): {
				//BX-Series Commando Droid
				missionNamespace setVariable ["opf_reservesEliteCount", (missionNamespace getVariable "opf_reservesRegularCount" + (floor (random 2) +1))];
			};
			case (_rnd >= 80 && _rnd < 90): {
				//Tank
				missionNamespace setVariable ["opf_reservesTankCount", (missionNamespace getVariable "opf_reservesRegularCount" + (floor (random 1) +1))];
			};
			case (_rnd >= 90): {
				//Gunship
				missionNamespace setVariable ["opf_reservesHeliCount", (missionNamespace getVariable "opf_reservesRegularCount" + (floor (random 1) +1))];
			};
			default {
				//Default (which should not happen) is B1 Battledroid
				missionNamespace setVariable ["opf_reservesRegularCount", (missionNamespace getVariable "opf_reservesRegularCount" + (floor (random 5) +1))];
			};
		};
	};
};
