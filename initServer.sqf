DEBUG = TRUE;	//Enables systemChat debug messages

B1UnitTypes = [
	"ls_cis_b1_base",		//Some classnames appear multiple times to influence selection chance
	"ls_cis_b1_base",
	"ls_cis_b1_base",
	"ls_cis_b1_base",
	"ls_cis_b1_base",
	"ls_cis_b1_base",
	"ls_cis_b1_base",
	"ls_cis_b1_base",
	"ls_cis_b1_at_base",
	"ls_cis_b1_at_base",
	"ls_cis_b1_AA_base",
	"ls_cis_b1_AA_base",
	"ls_cis_b1_AA_base",
	"ls_cis_b1_grenadier_base",
	"ls_cis_b1_heavy_base",
	"ls_cis_b1_heavy_base",
	"ls_cis_b1_heavy_base",
	"ls_cis_b1_heavy_base",
	"ls_cis_b1_heavy_base",
	"ls_cis_b1_marksman_base",
	"ls_cis_b1_marksman_base"
];

sleep 1;

[] execVM "scripts\playerSave.sqf";
[] execVM "scripts\objectiveDetailAutosave.sqf";

//Load all necessary server settings from database
[] remoteExec ["bfm_fnc_loadObjectiveDetails", 2, false];
[] remoteExec ["bfm_fnc_loadOpforDetails", 2, false];
sleep 3;
[] remoteExec ["bfm_fnc_opforCommanderLogic", 2, false];
[] remoteExec ["bfm_fnc_loadPatrols", 2, false];
[] remoteExec ["bfm_fnc_loadBuildingDamage", 2, false];

//Prepairing HC Connection
addMissionEventHandler ["HandleDisconnect",
{
	//params ["_unit", "_id", "_uid", "_name"];
	[(_this select 0)] remoteExec ["bfm_fnc_savePlayerStats", 2, false];
	false;
}];

addMissionEventHandler ["BuildingChanged",
{
	//params ["_previousObject", "_newObject", "_isRuin"];
	if (_this select 2) then {
		[(_this select 0)] remoteExec ["bfm_fnc_saveBuildingDamage", 2, false];
	};
}];
