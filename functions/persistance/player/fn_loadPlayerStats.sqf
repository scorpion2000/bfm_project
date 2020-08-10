params ["_player"];

systemChat "Loading Player Stats";

_inidbi = ["new", "BFM_PlayerStats"] call OO_INIDBI;
_result = (["read", ["playerPersistance", str (getPlayerUID _player)]] call _inidbi);

if ((str _result) != "false") then {
	_player setPosASL _result#0;
	_player setDir _result#1;
	switch (_result#2) do {
		case "STAND": { _player playAction "PlayerStand" };
		case "CROUCH": { _player playAction "PlayerCrouch" };
		case "PRONE": { _player playAction "PlayerProne" };
		default { diag_log format ["Error loading stance for [ %1 ]", _player] };
	};

	if (typeName ((_result select 3) select 0) != "STRING") then {_player setVariable ["ace_advanced_fatigue_anreserve", ((_result select 3) select 0)]};
	if (typeName ((_result select 3) select 1) != "STRING") then {_player setVariable ["ace_advanced_fatigue_muscledamage", ((_result select 3) select 1)]};
	if (typeName ((_result select 3) select 2) != "STRING") then {_player setVariable ["ace_advanced_fatigue_anfatigue", ((_result select 3) select 2)]};
	if (typeName ((_result select 3) select 3) != "STRING") then {_player setVariable ["ace_advanced_fatigue_aimfatigue", ((_result select 3) select 3)]};
	if (typeName ((_result select 3) select 4) != "STRING") then {_player setVariable ["ace_advanced_fatigue_animhandler", ((_result select 3) select 4)]};
	if (typeName ((_result select 3) select 5) != "STRING") then {_player setVariable ["ace_advanced_fatigue_ae2reserve", ((_result select 3) select 5)]};
	if (typeName ((_result select 3) select 6) != "STRING") then {_player setVariable ["ace_advanced_fatigue_ae1reserve", ((_result select 3) select 6)]};

	if (typeName ((_result select 4) select 0) != "STRING") then {_player setVariable ["acex_field_rations_consumableactionscache", ((_result select 4) select 0)]};
	if (typeName ((_result select 4) select 1) != "STRING") then {_player setVariable ["acex_field_rations_hunger", ((_result select 4) select 1)]};
	if (typeName ((_result select 4) select 2) != "STRING") then {_player setVariable ["acex_field_rations_thirst", ((_result select 4) select 2)]};

	_medical = ((_result select 5) select 0);
	{
		//systemChat str _forEachIndex;
		_player setHitPointDamage [_x, ((_medical select 2) select _forEachIndex)];
	} forEach (_medical select 0);
	_medical = ((_result select 5) select 1);
	{
		//systemChat format ["%1, %2", (_x select 0), (_x select 1)];
		if (typeName (_x select 1) == "STRING") then {
			if ((_x select 1) != "nil" && (_x select 1) != "NONE") then {
				player setvariable [(_x select 0),(_x select 1),(_x select 2)];
			}
		} else {
			_player setVariable [(_x select 0), (_x select 1), (_x select 2)];
		}
	} forEach _medical;

	_player setUnitLoadout (_result#6);
	[true] remoteExec ["bfm_fnc_welcomeMessage", _player, false];
} else {
	[_player] remoteExec ["bfm_fnc_savePlayerStats", 2, false];
	[false] remoteExec ["bfm_fnc_welcomeMessage", _player, false];
	_player setPos getPos bluforBaseSpawnPoint vectorAdd [random [-3, 0, 3], random [-3, 0, 3], 0];
	_player setDir 90;
}
