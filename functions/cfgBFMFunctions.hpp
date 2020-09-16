class VintigoFunctions {
	tag = "BFM";

	class BFM_Random
	{
		file = "functions";
		
		class deployPlayer {};
		class objComplete {};
	};
	
	class BFM_PlayerPersistance 
	{
		file = "functions\persistance\player";
		
		class savePlayerStats {};
		class loadPlayerStats {};
		class welcomeMessage {};
	};

	class BFM_ServerPersistance 
	{
		file = "functions\persistance\server";
		
		class loadObjectiveDetails {};
		class saveObjectiveDetails {};
		class loadOpforDetails {};
		class saveOpforDetails {};
		class loadPatrols {};
		class savePatrol {};
		class saveBuildingDamage {};
		class loadBuildingDamage {};
	};

	class BFM_spawners
	{
		file = "functions\spawners";
		
		class laatSpawnBase {};
		class warthogSpawnBase {};
	};

	class BFM_OPFOR_unitSpawners
	{
		file = "functions\opf_spawn";
		
		class createCounterAttack {};
		class createHelpForce {};
		class createPatrol {};
		class createObjForce {};
		class deleteObjForce {};
		class createReinforcements {};
	};

	class BFM_Debug
	{
		file = "functions\debug";
		
		class perfMeter {};
	};

	class BFM_OPFOR_Commander
	{
		file = "functions\opf_commander";
		
		//class opforCommanderLogic {};
		class handleReinforcements {};
		class calc_pressure {};
	};

	class BFM_OPFOR_Commander
	{
		file = "functions\opf_commander\commander_pressure";
		
		class actionControl {};
		class counterAttack {};
		class createReinforcement {};
		class patrol {};
		class redistribute {};
		class redistributeHigh {};
		class reinforce {};
		class reinforceHigh {};
		class reinforceLow {};
	};
};