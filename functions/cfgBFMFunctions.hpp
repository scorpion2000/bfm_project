class VintigoFunctions {
	tag = "BFM";

	class BFM_Random
	{
		file = "functions";
		
		class deployPlayer {};
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
		
		class opforCommanderLogic {};
		class handleReinforcements {};
	};
};