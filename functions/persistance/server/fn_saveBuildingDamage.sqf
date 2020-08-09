params ["_building"];

_inidbi = ["new", "BFM_WorldDetails"] call OO_INIDBI;
["write", ["destroyed_buildings", "destroyed_building_count", DESTROYED_BUILDINGS]] call _inidbi;
["write", ["destroyed_buildings", DESTROYED_BUILDINGS, str _building]] call _inidbi;
DESTROYED_BUILDINGS = DESTROYED_BUILDINGS +1;
