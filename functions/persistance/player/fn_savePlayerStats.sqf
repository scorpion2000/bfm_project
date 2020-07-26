/*
	SAVE PARAMS
		Position (ASL)
		Direction
		Stance
		Fatigue
		ACEX Field ration
		ACE Medical status
*/

params ["_player"];

systemChat "Starting Player Stat Save";
_saveArray = [];

_saveArray pushBack (getPosASL _player);
_saveArray pushBack (getDir _player);
_saveArray pushBack (stance _player);

_fatigueArray = [];
_fatigueArray pushBack (if (isNil {_player getVariable "ace_advanced_fatigue_anreserve"}) then {"NONE"} else {_player getVariable "ace_advanced_fatigue_anreserve"});
_fatigueArray pushBack (if (isNil {_player getVariable "ace_advanced_fatigue_muscledamage"}) then {"NONE"} else {_player getVariable "ace_advanced_fatigue_muscledamage"});
_fatigueArray pushBack (if (isNil {_player getVariable "ace_advanced_fatigue_anfatigue"}) then {"NONE"} else {_player getVariable "ace_advanced_fatigue_anfatigue"});
_fatigueArray pushBack (if (isNil {_player getVariable "ace_advanced_fatigue_aimfatigue"}) then {"NONE"} else {_player getVariable "ace_advanced_fatigue_aimfatigue"});
_fatigueArray pushBack (if (isNil {_player getVariable "ace_advanced_fatigue_animhandler"}) then {"NONE"} else {_player getVariable "ace_advanced_fatigue_animhandler"});
_fatigueArray pushBack (if (isNil {_player getVariable "ace_advanced_fatigue_ae2reserve"}) then {"NONE"} else {_player getVariable "ace_advanced_fatigue_ae2reserve"});
_fatigueArray pushBack (if (isNil {_player getVariable "ace_advanced_fatigue_ae1reserve"}) then {"NONE"} else {_player getVariable "ace_advanced_fatigue_ae1reserve"});
_saveArray pushBack _fatigueArray;

_rationsArray = [];
_rationsArray pushBack (if (isNil {_player getVariable "acex_field_rations_consumableactionscache"}) then {"NONE"} else {_player getVariable "acex_field_rations_consumableactionscache"});
_rationsArray pushBack (if (isNil {_player getVariable "acex_field_rations_hunger"}) then {"NONE"} else {_player getVariable "acex_field_rations_hunger"});
_rationsArray pushBack (if (isNil {_player getVariable "acex_field_rations_thirst"}) then {"NONE"} else {_player getVariable "acex_field_rations_thirst"});
_saveArray pushBack _rationsArray;

_medicalArray = [];
_armaValues = getAllHitPointsDamage _player;
_aceValues = [];
_aceChecks = [
	["ace_medical_pain",true],
	["ace_medical_morphine",true],
	["ace_medical_bloodVolume",true],
	//["ACE_isUnconscious",true],
	["ace_medical_tourniquets",true],
	["ace_medical_occludedMedications",true],
	["ace_medical_openWounds",true],
	["ace_medical_bandagedWounds",true],
	["ace_medical_internalWounds",true],
	["ace_medical_lastUniqueWoundID",true],
	["ace_medical_heartRate",false],
	["ace_medical_heartRateAdjustments",false],
	["ace_medical_bloodPressure",false],
	["ace_medical_peripheralResistance",false],
	["ace_medical_fractures",true],
	["ace_medical_triageLevel",true],
	["ace_medical_triageCard",true],
	["ace_medical_ivBags",true],
	["ace_medical_bodyPartStatus",true],
	["ace_medical_airwayStatus",false],
	["ace_medical_airwayOccluded",false],
	["ace_medical_airwayCollapsed",false],
	//["ace_medical_addedToUnitLoop",true],
	["ace_medical_inCardiacArrest",true],
	["ace_medical_hasLostBlood",true],
	["ace_medical_isBleeding",true],
	["ace_medical_hasPain",true],
	["ace_medical_amountOfReviveLives",true],
	["ace_medical_painSuppress",true],
	["ace_medical_allUsedMedication",true],
	["ace_medical_allLogs",true],
	["ace_medical_pain",true]
	//["ace_medical_islimping"],
	//["ace_medical_handledamageehid"],
	//["ace_medical_vitals_lasttimeupdated"],
	//["ace_medical_vitals_lastmomentvaluessynced"],
	//["ace_medical_engine_aimfracture]"
];

{
	_aceValues pushBack [(_x select 0), _player getVariable [(_x select 0), "nil"], (_x select 1)];
} forEach _aceChecks;

_medicalArray pushBack _armaValues;
_medicalArray pushBack _aceValues;
_saveArray pushBack _medicalArray;

_saveArray pushback (getUnitLoadout _player);

_inidbi = ["new", "BFM_PlayerStats"] call OO_INIDBI;
["write", ["playerPersistance", str (getPlayerUID _player), _saveArray]] call _inidbi;
