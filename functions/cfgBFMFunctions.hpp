class VintigoFunctions {
	tag = "BFM";
	
	class BFM_PlayerPersistance 
	{
		file = "functions\persistance\player";
		
		class savePlayerStats {};
		class loadPlayerStats {};
		
	};

	class BFM_ServerPersistance 
	{
		file = "functions\persistance\server";
		
		class loadObjectiveDetails {};
		class saveObjectiveDetails {};
		class loadOpforDetails {};
		class saveOpforDetails {};
		class handleReinforcements {};
		
	};

	class BFM_spawners
	{
		file = "functions\spawners";
		
		class laatSpawnBase {};
		
	};
};