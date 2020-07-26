_objective_0 = [
	0,		//ID
	"Communications Center",
	15,		//Regular B1 Count
	3,		//Mostly BX-Series Commando Droids
	1,		//Tanks
	0,		//Attack Gunships
	false	//Checks if the objective is in Blufor hands or not
];

missionNamespace setVariable ["objective_0", _objective_0];

_objective_1 = [
	1,		//ID
	"Long Range Artillery Cannon",
	40,		//Regular B1 Count
	6,		//Mostly BX-Series Commando Droids
	3,		//Tanks
	1,		//Attack Gunships
	false	//Checks if the objective is in Blufor hands or not
];

missionNamespace setVariable ["objective_1", _objective_1];

_objective_2 = [
	2,		//ID
	"Separatist Landing Zone",
	60,		//Regular B1 Count
	14,		//Mostly BX-Series Commando Droids
	4,		//Tanks
	2,		//Attack Gunships
	false	//Checks if the objective is in Blufor hands or not
];

missionNamespace setVariable ["objective_2", _objective_2];

_objective_3 = [
	3,		//ID
	"Separatist Outpost",
	60,		//Regular B1 Count
	14,		//Mostly BX-Series Commando Droids
	4,		//Tanks
	2,		//Attack Gunships
	false	//Checks if the objective is in Blufor hands or not
];

missionNamespace setVariable ["objective_3", _objective_3];

_objective_4 = [
	4,		//ID
	"Research Station",
	20,		//Regular B1 Count
	8,		//Mostly BX-Series Commando Droids
	0,		//Tanks
	0,		//Attack Gunships
	false	//Checks if the objective is in Blufor hands or not
];

missionNamespace setVariable ["objective_4", _objective_4];

_objective_5 = [
	5,		//ID
	"Separatist HQ",
	50,		//Regular B1 Count
	12,		//Mostly BX-Series Commando Droids
	2,		//Tanks
	1,		//Attack Gunships
	false	//Checks if the objective is in Blufor hands or not
];

missionNamespace setVariable ["objective_5", _objective_5];

_objective_6 = [
	6,		//ID
	"Solar Farm",
	20,		//Regular B1 Count
	2,		//Mostly BX-Series Commando Droids
	0,		//Tanks
	0,		//Attack Gunships
	false	//Checks if the objective is in Blufor hands or not
];

missionNamespace setVariable ["objective_6", _objective_6];
[] execVM "scripts\checkObjectivesForBlufor.sqf";
[] remoteExec ["bfm_fnc_saveObjectiveDetails", 2, false];
